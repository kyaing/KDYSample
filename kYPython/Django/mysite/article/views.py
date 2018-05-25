from django.shortcuts import render, render_to_response
from django.http import HttpRequest, HttpResponse, Http404
from .models import Article

# Create your views here.
def article_detail(request, article_id):
    try:
        article = Article.objects.get(id=article_id)
        context = {}
        context['article_obj'] = article
        return render(request, 'article_detail.html', context)
    except Article.DoesNotExist:
        return Http404('Not Exist')
    # return HttpResponse('<h2>文章标题：%s</h2> <br> 文章内容：%s' % (article.title, article.content))

def article_list(request):
    # articles = Article.objects.all()  
    articles = Article.objects.filter(is_deleted=False)
    context = {}
    context['articles'] = articles
    return render_to_response('article_list.html', context)
