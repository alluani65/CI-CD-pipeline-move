from django.forms import ModelForm
from.models import Movie
class Movieform(ModelForm):
    class Meta:
        model=Movie
        fields=['name','des','year','img']