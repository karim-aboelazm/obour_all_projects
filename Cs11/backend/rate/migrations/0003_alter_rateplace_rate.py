# Generated by Django 4.1.3 on 2023-06-15 17:57

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("rate", "0002_alter_rateplace_user_alter_rateplace_unique_together_and_more"),
    ]

    operations = [
        migrations.AlterField(
            model_name="rateplace",
            name="rate",
            field=models.DecimalField(
                blank=True, decimal_places=2, max_digits=4, null=True
            ),
        ),
    ]
