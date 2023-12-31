# Generated by Django 4.1.7 on 2023-04-11 23:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("islamic", "0022_questionsandanswers"),
    ]

    operations = [
        migrations.CreateModel(
            name="ChatHistory",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("question", models.CharField(max_length=500)),
                ("Answer", models.TextField()),
            ],
            options={
                "verbose_name_plural": "Chat History",
            },
        ),
    ]
