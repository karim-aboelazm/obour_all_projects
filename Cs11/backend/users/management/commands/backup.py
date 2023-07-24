import os
import shutil

from django.conf import settings
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = 'Create a backup of the SQLite file and media directory'

    def handle(self, *args, **options):
        backup_dir = os.path.join(settings.BASE_DIR, 'backup')

        if not os.path.exists(backup_dir):
            os.makedirs(backup_dir)
        else:
            shutil.rmtree(backup_dir)
            os.makedirs(backup_dir)
        db_path = os.path.join(settings.BASE_DIR, 'db.sqlite3')
        # if media dir not exist, create it
        if not os.path.exists(os.path.join(settings.BASE_DIR, 'media')):
            os.makedirs(os.path.join(settings.BASE_DIR, 'media'))
        media_path = os.path.join(settings.BASE_DIR, 'media')
        backup_db_path = os.path.join(backup_dir, 'db.sqlite3')
        backup_media_path = os.path.join(backup_dir, 'media')
        shutil.copy2(db_path, backup_db_path)
        shutil.copytree(media_path, backup_media_path)
        self.stdout.write(self.style.SUCCESS('Backup created successfully'))
