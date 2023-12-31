# Generated by Django 3.2.19 on 2023-06-14 23:23

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('library_template', '0019_article_outlines'),
    ]

    operations = [
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
        migrations.AlterField(
            model_name='article',
            name='outlines',
            field=models.ManyToManyField(through='library_template.OutlineOrder', to='library_template.Outline'),
        ),
    ]
