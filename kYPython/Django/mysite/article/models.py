from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User

# Create your models here.
class Article(models.Model):
    title = models.CharField(max_length=30) 
    content = models.TextField()
    create_time = models.DateTimeField(default=timezone.now)  # 添加了字段，并设置了默认值
    last_update_time = models.DateTimeField(auto_now=True)
    auther = models.ForeignKey(User, on_delete=models.DO_NOTHING, default=1)  # 外键 ForeignKey
    is_deleted = models.BooleanField(default=False)
    readed_num = models.IntegerField(default=0)

    def __str__(self):
        return '<Article>: %s' % self.title
     