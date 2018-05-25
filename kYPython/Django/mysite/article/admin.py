from django.contrib import admin
from .models import Article

# Register your models here.
class ArticleAdmin(admin.ModelAdmin):
    list_display = ('title', 'content', 'auther', 'is_deleted', 'readed_num', 'create_time', 'last_update_time')  # list_display 显示列表
    ordering = ('id',)  # 添加以 id 为字段，并且排序，

admin.site.register(Article, ArticleAdmin)
