import json

from django.apps import apps
from django.core import serializers
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = 'Export database data to JSON'

    def add_arguments(self, parser):
        parser.add_argument('path', type=str, help='Output file path')

    def handle(self, *args, **options):
        # Discover all models in the system
        models = apps.get_models()

        # Export data for each model
        export_data = {}
        for model in models:
            queryset = model.objects.all()
            data = serializers.serialize('json', queryset)

            # Add data to export dictionary using model name as key
            export_data[model.__name__] = data

        # Save export data to file
        path = options['path']
        with open(path, 'w') as f:
            f.write(json.dumps(export_data, indent=4))

        self.stdout.write(self.style.SUCCESS(f'Successfully exported data to {path}'))
