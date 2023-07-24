from django.views.generic import ListView, CreateView,View , DetailView
import uuid
from django.urls import reverse_lazy
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from .models import Block2 as Block , Article
from library_template.models import Article as editor_articles
from django.shortcuts import render
from django.core.exceptions import ObjectDoesNotExist
import json
from .functions import *

class LongFormEditorView(LoginRequiredMixin,CreateView):
    template_name = 'long form editor/Long-form-editor.html'

    def get(self, request, *args, **kwargs):
        return render(request, self.template_name)
    
    
class SaveArticleTitleView(View):
    def post(self, request, *args, **kwargs):
        title = request.POST.get('article_title')
        
        # Get the current article ID from the request
        article = editor_articles.objects.create(
            title=title,
            user=request.user)
        article.save()
        
        
        # Create a new article with the provided title
        article = Article(library_article=article, title=title)
        article.save()


        self.request.session['article_id'] = article.id
        return JsonResponse({'success': True})

    def get(self, request, *args, **kwargs):
        return JsonResponse({'success': False, 'error': 'Invalid request method'})


class CreateBlockView(View):
    def post(self, request, *args, **kwargs):
        content = request.POST.get('content')
        block_type = request.POST.get('block_type')
        position = int(request.POST.get('position'))
        unique_id = request.POST.get('unique_id')

        # Get the current article ID from the request
        article_id = self.request.session.get('article_id')

        try:
            # Fetch the article based on the provided ID
            article = Article.objects.get(id=article_id)

            # Create a new block associated with the article
            block = Block(article=article, content=content, block_type=block_type, position=position, unique_id=unique_id)
            block.save()

            return JsonResponse({'success': True})
        except ObjectDoesNotExist:
            return JsonResponse({'success': False, 'error': 'Article does not exist'}, status=404)

    def get(self, request, *args, **kwargs):
        return JsonResponse({'success': False, 'error': 'Invalid request method'})
    
class AskFeatherView(View):
    def post(self, request, *args, **kwargs):
        try:
            payload = json.loads(request.body)
            question = payload.get('question')

            response = {
                'question': question,
                'answer': chat_feather(question)['output'],
            }

            return JsonResponse(response)
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON payload'})

    def get(self, request, *args, **kwargs):
        return JsonResponse({'error': 'Invalid request method'})
    
def UpdateBlockPositionsView(request):
    if request.method == 'POST':
        positions = json.loads(request.body)
        print(positions)
        # Update block positions in the database
        for position in positions:
            block_id = position['id']
            new_position = position['position']
        
            try:
                block = Block.objects.get(unique_id=block_id)
                block.position = new_position
                block.save()
            except Block.DoesNotExist:
                # Handle block not found error
                pass

        return JsonResponse({'success': True})
    
    return JsonResponse({'success': False, 'error': 'Invalid request method'})

class ArticleView(DetailView):
    model = Article
    template_name = 'saved_copies/long_form_editor_view.html'
    context_object_name = 'article'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        # Fetch the article object
        article = self.get_object()

        # Fetch the associated Block2 objects
        blocks = article.blocks.all()

        # Prepare the Block2 data
        block_data = []
        for block in blocks:
            block_data.append({
                'content': block.content,
                'block_type': block.block_type,
                'position': block.position,
                'unique_id': block.unique_id,
            })

        # Add the Block2 data to the context
        context['blocks'] = block_data

        return context


