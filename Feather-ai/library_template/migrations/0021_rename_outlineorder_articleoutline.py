# Generated by Django 3.2.19 on 2023-06-14 23:24

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('library_template', '0020_auto_20230615_0223'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='OutlineOrder',
            new_name='ArticleOutline',
        ),
    ]
