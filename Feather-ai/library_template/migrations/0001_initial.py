# Generated by Django 3.2.19 on 2023-06-10 15:37

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Article',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('article_text', models.TextField()),
                ('image', models.ImageField(blank=True, upload_to='images/')),
                ('content', models.TextField()),
                ('tags', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Idea',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('tone_of_voice', models.CharField(max_length=100)),
                ('language', models.CharField(max_length=100)),
                ('idea_text', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='Outline',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('keyword', models.CharField(max_length=100)),
                ('outline_name', models.CharField(max_length=100)),
                ('sub_topic', models.CharField(max_length=100)),
                ('sub_topic_text', models.TextField()),
                ('idea', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='library_template.idea')),
            ],
        ),
        migrations.CreateModel(
            name='Topic',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('keywords', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='OutlineOrder',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('order', models.IntegerField()),
                ('article', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='library_template.article')),
                ('outline', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='library_template.outline')),
            ],
            options={
                'ordering': ['order'],
            },
        ),
        migrations.AddField(
            model_name='idea',
            name='topic',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='library_template.topic'),
        ),
        migrations.AddField(
            model_name='article',
            name='outlines',
            field=models.ManyToManyField(through='library_template.OutlineOrder', to='library_template.Outline'),
        ),
    ]
