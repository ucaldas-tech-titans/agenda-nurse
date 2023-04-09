import pandas as pd
import random
from os import remove

#por ahora no está implementado lo de vacaciones

#dias que requieren personal
# institucionalizados = 30
# mujeres = 30
# juanciudad = 30
# sanrafael = 30
# intermediasmujeres = 30
# n1 = 30
# hombres = 30

class HorarioPersona():
    def __init__(self,nombre):
        self.nombre = nombre
        #si el horario es de 31 días poner 31 en vez de 30
        self.horario = ["L"]*30
    # si persona tiene menos de 8 dias libres no asigne horario
    def contarLibres(self):
        aux = 0
        for i in self.horario:
            if i.upper() == "L":
                aux += 1
        return aux
    #se usa para crear el archivo .csv
    def returnArray(self):
        arr = self.horario.copy()
        arr.insert(0,self.nombre)
        return arr

cantidadPersonas = 19

#19 personas
horarios = [0] * cantidadPersonas

for i in  range(cantidadPersonas):
    horarios[i] = HorarioPersona("Persona" + str(i + 1))

def buscarDiasSiNombreAsignado(dia,nombre):
    #dia es un número de 0 a 31
    global horarios
    for i in range(len(horarios)):
        if horarios[i].horario[dia] == nombre:
            return True
    return False

def asignarHorarios(nombre):
    global horarios
    aux = 0
    while aux < len(horarios[0].horario):
        h = random.randint(0,len(horarios)-1)
        dia = random.randint(0,len(horarios[0].horario)-1)
        if horarios[h].horario[dia].upper() == "L":
            # si persona tiene mas de 8 dias libres asigne horario
            if horarios[h].contarLibres() >=8:
                #revisar que en ese día no hayan horarios asignados con ese nombre
                if buscarDiasSiNombreAsignado(dia,nombre) == False:
                    horarios[h].horario[dia] = nombre
                    aux += 1
                    continue

def asignarHorariosN1(nombre="N1"):
    global horarios
    aux = 0
    while aux < len(horarios[0].horario):
        h = random.randint(0,len(horarios)-1)
        h2 = random.randint(0,len(horarios)-1)
        dia = random.randint(0,len(horarios[0].horario)-1)

        if horarios[h].horario[dia].upper() == "L" and horarios[h2].horario[dia].upper() == "L":
            if horarios[h].contarLibres() >=8 and horarios[h2].contarLibres() >=8:
                if buscarDiasSiNombreAsignado(dia,nombre) == False:
                    horarios[h].horario[dia] = nombre
                    horarios[h2].horario[dia] = nombre
                    aux += 1
                    continue

asignarHorarios("Institucionalizados")
asignarHorarios("Mujeres")
asignarHorarios("JuanCiudad")
asignarHorarios("SanRafael")
asignarHorarios("IntermediasMujeres")
asignarHorarios("Hombres")
asignarHorarios("Vivo")
asignarHorariosN1()

#para mostrar en index.html
def escribirArchivo(aux):
    remove("horarios.js")
    with open("horarios.js","a") as f:
        f.write("let horarios = [")
        for i in range(len(aux)):
            if i == len(aux)-1:
                f.write(str(aux[i]))
            else:
                f.write(str(aux[i]) + ",")
        f.write("];")
        

aux = [0] * len(horarios)
for i in range(len(horarios)):
    aux[i] = horarios[i].returnArray()

escribirArchivo(aux)

dt = pd.DataFrame(aux)

dt.to_csv("archivo.csv",index=False)


