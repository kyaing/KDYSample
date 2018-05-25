from django.urls import path
from . import views

urlpatterns = [
    # localhost:8000/articel/id
    path('<int:article_id>', views.article_detail, name='article_detail'),
    # localhost:8000/articel
    path('', views.article_list, name='article_list'),
]
