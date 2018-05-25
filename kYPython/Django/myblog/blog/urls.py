from django.urls import path
from .views import blog_list, blog_detail

urlpatterns = [
    # http://localhost:8000/blog/1
    path('<int:blog_pk>', blog_detail, name='blog_detail'),
]
