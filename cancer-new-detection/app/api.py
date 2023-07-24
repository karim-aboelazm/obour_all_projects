from rest_framework.parsers import MultiPartParser
from tensorflow.keras.preprocessing import image
from tensorflow.keras.models import load_model
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import CreateAPIView
from rest_framework import status
from .serializers import *
from .models import *
import numpy as np

class_labels = ['benign','malignant']

def process_image(image_file):
    img = image.load_img(image_file, target_size=(256,256))
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = x / 255.0
    return x

class SkinApi(APIView):
    parser_classes = [MultiPartParser]
    def post(self, request, format=None):
        # Save the uploaded image to the database
        serializer = SkinPostSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()

            # Load the pre-trained model
            model_path = 'skin_cancer.h5'
            model = load_model(model_path)

            # Get the last uploaded image from the database
            last_obj = SkinImagePrediction.objects.latest('id')

            # Process the image for input to the model
            # This could involve resizing, normalization, etc.
            processed_image = process_image(last_obj.image.path)
            predictions = model.predict(processed_image)
            # predicted_class_index = np.argmax(predictions[0])
            if predictions < 0.5:
                predicted_class = class_labels[0]
            else:
                predicted_class = class_labels[1]
            # Update the class label of the last object
            last_obj.classes = predicted_class
            last_obj.save()

            # Return the updated object as a response
            serializer = SkingetSerializer(last_obj)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def get(self, request, format=None):
        # Get the last object from the database
        last_object = SkinImagePrediction.objects.last()

        # Serialize and return the object as a response
        serializer = SkingetSerializer(last_object)
        return Response(serializer.data)
