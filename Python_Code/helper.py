from random import randint
from docarray.document.generators import from_csv
from jina import DocumentArray

with open("Python_Code/data/Movies_Reduced.csv") as file:
    movies = DocumentArray(from_csv(file, field_resolver={'Summary': 'text'}))

movies = movies.shuffle(seed=randint)

for i in range(len(movies)):
    movies[i].text = movies[
        i].text + f"{ movies[i].tags['Genres'] }" + f"{ movies[i].tags['Title']}"
