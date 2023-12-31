# Generated by Django 4.1.7 on 2023-04-05 15:29

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("islamic", "0014_praylearningvideos"),
    ]

    operations = [
        migrations.CreateModel(
            name="ArkanTypes",
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
                ("title", models.CharField(max_length=250)),
            ],
            options={
                "verbose_name_plural": "Arkan Type",
            },
        ),
        migrations.CreateModel(
            name="ArkanContent",
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
                ("content", models.TextField()),
                (
                    "rokn",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="islamic.arkantypes",
                    ),
                ),
            ],
            options={
                "verbose_name_plural": "Arkan Content",
            },
        ),
    ]
