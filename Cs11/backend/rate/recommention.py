import pickle
import pandas as pd
from rest_framework.response import Response
from kemet.settings import BASE_DIR
from rest_framework.decorators import (
    api_view,
    authentication_classes,
    permission_classes,
)
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication


@api_view(["GET"])
@authentication_classes([JWTAuthentication])
@permission_classes([IsAuthenticated])
def recommendview(request):
    loaded_model = pickle.load(open("model.pkl", "rb"))
    loaded_vectorizer = pickle.load(open("vectorizer.pkl", "rb"))

    data = pd.read_csv("egypt_tourist_locations.csv")
    user_id = request.user.pk
    user_data = data[data["user_id"] == user_id]
    categories = user_data["category"].unique()
    vectorized_text = loaded_vectorizer.transform(categories)
    recommended_places = loaded_model.predict(vectorized_text)

    print(f"Recommended Places for User {user_id}:")
    places_dict = {}
    for category, place in zip(
        data[data["user_id"] == user_id]["category"], recommended_places
    ):
        if category not in places_dict:
            places_dict[category] = [place]
        else:
            places_dict[category].append(place)
    print(recommended_places)
    return Response(recommended_places)
