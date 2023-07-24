from django.shortcuts import render
from django.views.generic import ListView,View,DetailView
from django.contrib.auth.mixins import LoginRequiredMixin
from library_template.models import Article
from datetime import date, timedelta,datetime
import calendar
from django.shortcuts import redirect
from django.urls import reverse
from django.template.loader import render_to_string
from django.shortcuts import get_object_or_404

class SavedCopiesView(LoginRequiredMixin, ListView):
    model = Article
    template_name = 'saved_copies/saved_copies.html'
    context_object_name = 'saved_articles'
        
    def get_queryset(self):
        queryset = super().get_queryset().filter(user=self.request.user).prefetch_related('outlines__suboutline_set')

        date_range = self.request.GET.get('date_range')
        if date_range:
            date_parts = date_range.split('-')
            start_day = int(date_parts[0])
            end_day = int(date_parts[1])
            month_name = date_parts[2]

            year =int(date_parts[3]) 
            
            month = datetime.strptime(month_name, '%b').month

            start_date = datetime.strptime(f'{year}-{month}-{start_day}', '%Y-%m-%d').date()
            end_date = datetime.strptime(f'{year}-{month}-{end_day}', '%Y-%m-%d').date()

            queryset = queryset.filter(created_at__date__gte=start_date, created_at__date__lte=end_date)
            self.request.session['active_date_range'] = date_range
        return queryset
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if Article.objects.filter(user=self.request.user).exists():
            first_article_date = Article.objects.filter(user=self.request.user).first().created_at
        else :
            first_article_date = date.today()
        num_date_ranges = int(self.request.GET.get('num_date_ranges', 250))  # Number of date ranges to retrieve
        date_range_group = self.request.GET.get('date_range')  # Get the date_range parameter from the URL
        context['active_date_range'] = self.request.GET.get('date_range')
        date_ranges = []
        day_data = []
        
        if Article.objects.filter(user=self.request.user).exists():
            current_date = first_article_date.date()  # Extract the date part
        
        else:
            current_date = date.today()
            
        for i in range(num_date_ranges):
            start_date = current_date
            end_date = current_date + timedelta(days=4)
            range_start = start_date.strftime("%d")
            range_end = end_date.strftime("%d")
            range_month = start_date.strftime("%b")
            range_year = start_date.strftime("%Y")
            date_range = {
                'start_day': range_start,
                'end_day': range_end,
                'month': range_month,
                'year': range_year
            }
            date_ranges.append(date_range)
            current_date = end_date + timedelta(days=1)  # Move to the next range
        if date_range_group:
            date_parts = date_range_group.split('-')
            start_day = int(date_parts[0])
            end_day = int(date_parts[1])
            month_name = date_parts[2]
            year = int(date_parts[3])
            month = datetime.strptime(month_name, '%b').month

            _, max_days = calendar.monthrange(year, month)
            if end_day < start_day:
                # Extend the end day to the maximum days in the current month
                end_day = max_days

            start_date = datetime(year=year, month=month, day=start_day).date()
            end_date = datetime(year=year, month=month, day=end_day).date()

            # Iterate over the range of dates in the current month
            current_date = start_date
            while current_date <= end_date:
                day_data.append({
                    'day_number': current_date.day,
                    'day_name': current_date.strftime("%A")
                })
                current_date += timedelta(days=1)

            if len(day_data) < 5:
                remaining_days = 5 - len(day_data)
                next_month = month + 1
                if next_month > 12:
                    next_month = 1
                    year += 1
                _, max_days = calendar.monthrange(year, next_month)

                # Append remaining days from the current month
                for day in range(1, remaining_days + 1):
                    if day <= max_days:
                        day_data.append({
                            'day_number': day,
                            'day_name': datetime(year=year, month=next_month, day=day).strftime("%A")
                        })

        context['date_ranges'] = date_ranges
        context['day_data'] = day_data
        return context
    
class DeleteArticleView(LoginRequiredMixin,View):
    
    def post(self, request, pk):
        article = Article.objects.get(pk=pk)
        article.delete()
        
        url = reverse('saved-copies') + f'?date_range={request.session["active_date_range"]}'

        return redirect(url)
    
class ArticleDetailView(DetailView):
    model = Article
    template_name = 'saved_copies/article_detail.html'
    context_object_name = 'article'
    
class ArticleDetailPrev1View(DetailView):
    model = Article
    template_name = 'saved_copies/article_detail-1.html'
    context_object_name = 'article'
    
class ArticleDetailPrev2View(DetailView):
    model = Article
    template_name = 'saved_copies/article_detail-2.html'
    context_object_name = 'article'
    
class ArticleDetailPrev3View(DetailView):
    model = Article
    template_name = 'saved_copies/article_detail-3.html'
    context_object_name = 'article'
    
class ExportPDFView(View):
    def get(self, request, article_id, *args, **kwargs):
        # Retrieve the article based on its ID
        article = get_object_or_404(Article, id=article_id)

        # Render the HTML template with the desired section
        html_string = render_to_string('saved_copies/article_detail.html', {'article': article, 'export_mode': True})

        # Create a PDF object from the HTML string
        pdf = HTML(string=html_string).write_pdf()

        # Create an HTTP response with the PDF file
        response = HttpResponse(content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="article_{article_id}.pdf"'
        response.write(pdf)

        return response