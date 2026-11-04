from django.http import HttpResponse
from django.shortcuts import render, redirect
from.forms import Movieform
from .models import Movie


# Create your views here.
def index(request):
    m={'movie':Movie.objects.all()}
    return render(request,'index.html',m)

def Detail(request,movie_id):
    a={'movie':Movie.objects.get(id=movie_id)}
    return render(request,'detail.html',a)
def add(request):
    if request.method=='POST':
        name=request.POST.get('name')
        des=request.POST.get('des')
        year=request.POST.get('year')
        img=request.FILES['img']
        movie=Movie(name=name,des=des,year=year,img=img)
        movie.save()
    return render(request,'add.html')

def update(request,id):
    movie=Movie.objects.get(id=id)
    form=Movieform(request.POST or None ,request.FILES,instance=movie)
    if form.is_valid():
        form.save()
        return redirect('/')
    return render(request,'update.html',{'movie':movie,'form':form})

def delete(request,id):
    if request.POST:
        d=Movie.objects.get(id=id)
        d.delete()
        return redirect('/')
    return render(request,'delete.html')