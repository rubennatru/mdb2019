#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan 15 18:24:21 2020

@author: master
"""

var=45
var=89
var_segundo=99
print(var)

var = "Hola mundo master"
tupla = 1,2,3,"Hola"
tupla[3]
len(tupla)


import numpy as np
a = np.zeros((2,2))

import pandas as pd
dates = pd.date_range('20130101', periods =6)
df = pd.DataFrame(np.random.randn(6,4), index=dates, columns=list('ABCD'))

df.describe()
df.plot()
df.figure()



##################################################### Importing required packages ################################################## 



#import sys

import re
import os
import pandas as pd
import numpy as np

#%matplotlib inline

import matplotlib.pyplot as plt 

import seaborn as sns

import json



import folium

#%folium inline



import pymongo

from pymongo import MongoClient #, GEO2D



###################################################### First data exploration #######################################################



# Data import from csv

total_crime=pd.read_csv('Map_of_Police_Department_Incidents.csv')


#Imprime numero de filas y de columnas
print(total_crime.shape)

#d_crime=total_crime.head(600000)
seed =1
d_crime=total_crime.sample(frac=0.30, random_state=seed)
del(total_crime)#delete pandas dataframe from memory(Borra el anterior con la funcion del)

d_crime.dtypes#tipos de cada uno de los campos

d_crime.head(20)#Para ver los 20 primeros registros
d_crime.tail(20)
d_crime['Category']#Ver el tipo de categorias
d_crime['Category'].value_counts()#cuenta todas las categorias



# Data cleaning. Transform Data from string to date type and delta date

date=pd.to_datetime(d_crime['Date']) #

print(date.min())
print(date.max())

# Create a new colum "days" with timedelta format

t_delta=(date-date.min()).astype('timedelta64[D]')
d_crime['days']=t_delta#Añade una columna al archivo d_crime
d_crime.head(1)



# Export subset of Data to csv
#d_crime.to_csv('C:\\Users\\Jose-Manuel\\Documents\\DOCENCIA\\MASTER-BD-ADVANCED-ANALYTICS\\2017-2018\\Module5\\Map_of_Police_Department_Incidents-Subset2.csv')

d_crime.to_csv('Map_of_Police_Department_Incidents-Subset-export.csv')#Guardar el archivo como csv y con ese nombre

d_crime.to_json('Map_of_Police_Department_Incidents-Subset-export.json')#Guardar el archivo como json y con ese nombre


grupo=d_crime.groupby('Category')

d_crime.groupby('DayOfWeek').size()
d_crime.groupby('Category').size()
d_crime.groupby('Date').size()
########################### LET'S GO TO A FIRST EXCERCISE OF DATA EXPLORATION ###############################

#d_crime.groupby('DayOfWeek').size()


cat='Category'

data = d_crime


# Plotting bargraph
#Cambia el formato de la tabla
def plotdat(data,cat):
    l=data.groupby(cat).size()#Agrupa por cada una de los valores y nos dice cuantos hay
    s=l.sort_values(ascending=True)
    plt.figure(figsize=(10,5))
    plt.yticks(fontsize=8)
    s.plot(kind='bar',fontsize=10,color='g', )
    plt.xlabel('')
    plt.ylabel('Number of reports',fontsize=10)

plotdat(d_crime,'Category')
plotdat(d_crime,'PdDistrict')

plotdat(d_crime,'DayOfWeek')

#-----------------------------------------------------------------------------


group=d_crime
hoods_per_type=d_crime.groupby('Descript').PdDistrict.value_counts(sort=True)
t=hoods_per_type.unstack().fillna(0)

per=95

# Heatmap and hierarchical clustering

def types_districts(d_crime,per):
    # Group by crime type and district 
    hoods_per_type=d_crime.groupby('Descript').PdDistrict.value_counts(sort=True)
    t=hoods_per_type.unstack().fillna(0)

    # Sort by hood sum
    hood_sum=t.sum(axis=0)
    hood_sum.sort_values(ascending=False)
    t=t[hood_sum.index]

    # Filter by crime per district
    crime_sum=t.sum(axis=1)
    crime_sum.sort_values(ascending=False)
    
    # Large number, so let's slice the data.
    p=np.percentile(crime_sum,per)
    ix=crime_sum[crime_sum>p]
    t=t.loc[ix.index]
    return t

tp=types_districts(d_crime,95)
sns.clustermap(tp,cmap="mako", robust=True) #Para visualizar lo que hemos hecho en la funcion
sns.clustermap(tp,standard_scale=1,cmap="mako", robust=True) 
sns.clustermap(tp,standard_scale=0) 
plotdat(d_crime,'Category')


#Lesson2


# Let's drill down onto one

##################################################### Mongo Database connection and load #############################################



print('Mongo version', pymongo.__version__)
client = MongoClient('localhost', 27017)
db = client.test#Carpeta test que se crea en Mongo Compass
collection = db.crimesf

#Import data into the database

collection.drop()#Limpia la coleccion


#os.system('"C:\\Program Files\\MongoDB\\Server\\3.4\\bin\\mongoimport" -d test -c crimesf --type csv --file C:\\Users\\Jose-Manuel\\Documents\\DOCENCIA\\MASTER-BD-ADVANCED-ANALYTICS\\2017-2018\\Module5\\Map_of_Police_Department_Incidents-Subset2.csv --headerline')


records = json.loads(d_crime.to_json(orient='records'))#Lo guarda en formato Json
collection.delete_many({})#Limpia la coleccion para darle un formato standar
collection.insert_many(records)#Cargamos la base de datos



#Check if you can access the data from the MongoDB.

cursor = collection.find().sort('Category',pymongo.ASCENDING).limit(10)#Solo nos decuelve 10 registros

for doc in cursor:
    
    #print(doc)
    print(doc['Descript'])
    print(doc['IncidntNum'])

# stablish a pipeline to select all rows matching attribute "Category" = "DRUG/NARCOTIC"

pipeline = [

        {"$match": {"Category":"DRUG/NARCOTIC"}},

]


collection.find({"Category":"DRUG/NARCOTIC"}).count()


aggResult = collection.aggregate(pipeline)

df2 = pd.DataFrame(list(aggResult))

df2.head()


pipeline2 = [

        {"$match": {"DayOfWeek":"Friday"}}, {"$project": {"_id":0,"Date":1, "Descript":1}}, {"$limit":5}

]


pipeline3 = [

        {"$and": {"DayOfWeek":"Friday"}},

]


aggResult2 = collection.aggregate(pipeline2)


# Let's have a look on incidents' descriptions

c=df2['Descript'].value_counts()

c.sort_values(ascending=False)

c.head(10)



# Organize incidents' descriptions versus Districts where they were detected

def types_districts(d_crime,per):

    

    # Group by crime type and district 

    hoods_per_type=d_crime.groupby('Descript').PdDistrict.value_counts(sort=True)

    t=hoods_per_type.unstack().fillna(0)

    

    # Sort by hood sum

    hood_sum=t.sum(axis=0)

    hood_sum.sort_values(ascending=False)

    t=t[hood_sum.index]

    

    # Filter by crime per district

    crime_sum=t.sum(axis=1)

    crime_sum.sort_values(ascending=False)

    

    # Large number, so let's slice the data.

    p=np.percentile(crime_sum,per)

    ix=crime_sum[crime_sum>p]

    t=t.loc[ix.index]

    return t


t=types_districts(df2,75)


sns.clustermap(t)


sns.clustermap(t,standard_scale=1)


sns.clustermap(t,standard_scale=0)


##################################################### Time Series Analysis #############################################


# Bin crime by 30 day window. That is, obtain new colum with corresponding months 

df2['Month']=np.floor(df2['days']/30) # Approximate month (30 day window)


# Default

district='All'



def timeseries(dat,per):

    ''' Category grouped by month '''

    

    # Group by crime type and district 

    cat_per_time=dat.groupby('Month').Descript.value_counts(sort=True)

    t=cat_per_time.unstack().fillna(0)

  

    # Filter by crime per district

    crime_sum=t.sum(axis=0)

    crime_sum.sort_values()

    

    # Large number, so let's slice the data.

    p=np.percentile(crime_sum,per)

    ix=crime_sum[crime_sum>p]

    t=t[ix.index]

    

    return t


t_all=timeseries(df2,5)




#Find inciden's descriptions related to word patter "BARBITUATES"

pat = re.compile(r'BARBITUATES', re.I)




l=list(collection.find({"Category":"DRUG/NARCOTIC" , 'Descript': {'$regex': pat}}))


pipeline = [

        {"$match": {"Category":"DRUG/NARCOTIC" , 'Descript': {'$regex': pat}}},

]


aggResult = collection.aggregate(pipeline)

df3 = pd.DataFrame(list(aggResult))

df3.head()

barbituates = df3.groupby('Descript').size()

s = pd.Series(barbituates)

s = s[s != 1]

barituate_features = list(s.index)




#Find inciden's descriptions related to word patter "COCAINE"

def descriptionsAccordingToPattern(pattern):

    pat = re.compile(pattern, re.I)

   

    pipeline = [

            {"$match": {"Category":"DRUG/NARCOTIC" , 'Descript': {'$regex': pat}}},

    ]

    

    aggResult = collection.aggregate(pipeline)

    df3 = pd.DataFrame(list(aggResult))

    drug = df3.groupby('Descript').size()

    s = pd.Series(drug)

    s = s[s != 1] # filter those descriptions with value less equal 1

    features = list(s.index)

    

    return features


coke_features = descriptionsAccordingToPattern('COCAINE')

weed_features = descriptionsAccordingToPattern('MARIJUANA')

metadone_features = descriptionsAccordingToPattern('METHADONE')

hallu_features = descriptionsAccordingToPattern('HALLUCINOGENIC')

opium_features = descriptionsAccordingToPattern('OPIUM')

opiates_features = descriptionsAccordingToPattern('OPIATES')

meth_features = descriptionsAccordingToPattern('AMPHETAMINE')

heroin_features = descriptionsAccordingToPattern('HEROIN')

crack_features = descriptionsAccordingToPattern('BASE/ROCK')


# Lets use real dates for plotting

days_from_start=pd.Series(t_all.index*30).astype('timedelta64[D]')

dates_for_plot=date.min()+days_from_start

time_labels=dates_for_plot.map(lambda x: str(x.year)+'-'+str(x.month))


# Analytics per drug tipology according to descriptions

def drug_analysis(t,district,plot):

    t['BARBITUATES']=t[barituate_features].sum(axis=1)

    t['HEROIN']=t[heroin_features].sum(axis=1)

    t['HALLUCINOGENIC']=t[hallu_features].sum(axis=1)

    t['AMPHETAMINE']=t[meth_features].sum(axis=1)

    t['WEED']=t[weed_features].sum(axis=1)

    t['COKE']=t[coke_features].sum(axis=1)

    t['METHADONE']=t[metadone_features].sum(axis=1)

    t['CRACK']=t[crack_features].sum(axis=1)

    t['OPIUM']=t[opium_features].sum(axis=1)

    t['OPIATES']=t[opiates_features].sum(axis=1)


    drugs=t[['BARBITUATES','HEROIN','HALLUCINOGENIC','AMPHETAMINE','WEED','COKE','METHADONE','CRACK','OPIUM','OPIATES']]

    if plot:

        drugs.index=[int(i) for i in drugs.index]

        colors = plt.cm.jet(np.linspace(0, 1, drugs.shape[1]))

        drugs.plot(kind='bar', stacked=True, figsize=(20,5), color=colors, width=1, title=district,fontsize=6)

    return drugs


drug_df_all=drug_analysis(t_all,district,True)



def drug_analysis_rescale(t,district,plot):

    t['BARBITUATES']=t[barituate_features].sum(axis=1)

    t['HEROIN']=t[heroin_features].sum(axis=1)

    t['HALLUCINOGENIC']=t[hallu_features].sum(axis=1)

    t['AMPHETAMINE']=t[meth_features].sum(axis=1)

    t['WEED']=t[weed_features].sum(axis=1)

    t['COKE']=t[coke_features].sum(axis=1)

    t['METHADONE']=t[metadone_features].sum(axis=1)

    t['CRACK']=t[crack_features].sum(axis=1)

    t['OPIUM']=t[opium_features].sum(axis=1)

    t['OPIATES']=t[opiates_features].sum(axis=1)


    drugs=t[['BARBITUATES','HEROIN','HALLUCINOGENIC','AMPHETAMINE','WEED','COKE','METHADONE','CRACK','OPIUM','OPIATES']]

    if plot:

        drugs=drugs.div(drugs.sum(axis=1),axis=0)

        drugs.index=[int(i) for i in drugs.index]

        colors = plt.cm.GnBu(np.linspace(0, 1, drugs.shape[1]))

        colors = plt.cm.jet(np.linspace(0, 1, drugs.shape[1]))

        drugs.plot(kind='bar', stacked=True, figsize=(20,5), color=colors, width=1, title=district, legend=True)

        plt.ylim([0,1])

    return drugs


drug_df_all=drug_analysis_rescale(t_all,district,True)


##################################################### Focussing on real dates and Districts #############################################

# Let's add the real dates.

# And focusing on several types of drugs


dates_for_plot.index=dates_for_plot

sns.set_context(rc={"figure.figsize": (25.5,5.5)})

for d,c in zip(['AMPHETAMINE','CRACK','HEROIN','WEED'],['b','r','c','g']):

    plt.plot(dates_for_plot.index,drug_df_all[d],'o-',color=c,ms=6,mew=1.5,mec='white',linewidth=0.5,label=d,alpha=0.75)

plt.legend(loc='upper left',scatterpoints=1,prop={'size':8})


dates_for_plot.index=dates_for_plot

sns.set_context(rc={"figure.figsize": (25.5,5.5)})

for d,c in zip(['BARBITUATES','HALLUCINOGENIC','COKE','METHADONE'],['b','r','c','g']):

    plt.plot(dates_for_plot.index,drug_df_all[d],'o-',color=c,ms=6,mew=1.5,mec='white',linewidth=0.5,label=d,alpha=0.75)

plt.legend(loc='upper left',scatterpoints=1,prop={'size':8})


dates_for_plot.index=dates_for_plot

sns.set_context(rc={"figure.figsize": (25.5,5.5)})

for d,c in zip(['METHADONE','OPIUM','OPIATES'],['b','c','g']):

    plt.plot(dates_for_plot.index,drug_df_all[d],'o-',color=c,ms=6,mew=1.5,mec='white',linewidth=0.5,label=d,alpha=0.75)

plt.legend(loc='upper left',scatterpoints=1,prop={'size':8})


# To see more in depth, iterate through each district.


stor=[]

stor_time=[]



for d in d_crime['PdDistrict'].value_counts().index:

    # Specify district and group by time

        dist_dat=df2[df2['PdDistrict']==d]

        t=timeseries(dist_dat,10)

        # Merge to ensure all categories are preserved!

        t_merge=pd.DataFrame(columns=t_all.columns)

        m=pd.concat([t_merge,t],axis=0).fillna(0)

        m.reset_index(inplace=True)

        # Plot

        drug_df=drug_analysis(m,d,True)

        plt.show()

        s=drug_df.sum(axis=0)

        stor=stor+[s]

        drug_df.columns=cols=[c+"_%s"%d for c in drug_df.columns]

        stor_time=stor_time+[drug_df]

    

drug_dat_time=pd.concat(stor_time,axis=1)

drug_dat=pd.concat(stor,axis=1)

#drug_dat.columns=[list(set(d_crime['PdDistrict']))]

drug_dat.columns=[d_crime['PdDistrict'].value_counts().index]


########################################################### Correlation Analysis ##############################################

##We can also look at correlations between areas for different drugs.


sns.set_context(rc={"figure.figsize": (20,20)})

corr = drug_dat_time.corr()


# Generate a mask for the upper triangle

mask = np.zeros_like(corr, dtype=np.bool)

mask[np.triu_indices_from(mask)] = True


# Set up the matplotlib figure

f, ax = plt.subplots(figsize=(19, 19))


# Generate a custom diverging colormap

sns.set_context(rc={"figure.figsize": (20,20)})

cmap = sns.diverging_palette(220, 10, as_cmap=True)


sns.heatmap(corr,  mask=mask, cmap=cmap, vmax=.3, center=0, square=True, linewidths=.5, cbar_kws={"shrink": 0.5})


########################################################### Correlation Analysis ##############################################

#With this in mind, we can examine select timeseries data.


drug_dat_time.index=dates_for_plot.head(181)

sns.set_context(rc={"figure.figsize": (7.5,5)})

for d,c in zip(['METHADONE_MISSION','CRACK_MISSION'],['b','r']):

    plt.plot(drug_dat_time.index,drug_dat_time[d],'o-',color=c,ms=6,mew=1,mec='white',linewidth=0.5,label=d,alpha=0.75)

plt.legend(loc='upper left',scatterpoints=1,prop={'size':8})


drug_dat_time.index=dates_for_plot.head(181)

sns.set_context(rc={"figure.figsize": (7.5,5)})

for d,c in zip(['CRACK_MISSION','CRACK_TENDERLOIN','CRACK_BAYVIEW','CRACK_SOUTHERN'],['b','r','g','c']):

    plt.plot(drug_dat_time.index,drug_dat_time[d],'o-',color=c,ms=6,mew=1,mec='white',linewidth=0.5,label=d,alpha=0.75)

plt.legend(loc='upper left',scatterpoints=1,prop={'size':8})


######################################################### Spatial relationships -################################################

#Let's re-do what we did above, but re-scale it.


stor=[]

stor_time=[]


for d in d_crime['PdDistrict'].value_counts().index:

    # Specify district and group by time

    dist_dat=df2[df2['PdDistrict']==d]

    t=timeseries(dist_dat,0)

    # Merge to ensure all categories are preserved!

    t_merge=pd.DataFrame(columns=t_all.columns)

    m=pd.concat([t_merge,t],axis=0).fillna(0)

    m.reset_index(inplace=True)

    # Plot

    drug_df=drug_analysis_rescale(m,d,True)

    plt.show()

    s=drug_df.sum(axis=0)

    stor=stor+[s]

    drug_df.columns=cols=[c+"_%s"%d for c in drug_df.columns]

    stor_time=stor_time+[drug_df]
    
    
tmp=df2.copy()

tmp.set_index('Descript',inplace=True)


crack_dat=tmp.loc[crack_features]

crack_pts=crack_dat[['X','Y','Month']]


#Plot the crack regimes.


d=pd.DataFrame(crack_pts.groupby('Month').size())

d.index=dates_for_plot

d.columns=['Count']


diff=len(d.index)-120

plt.plot(d.index,d['Count'],'o-',color='k',ms=6,mew=1,mec='white',linewidth=0.5,label=d,alpha=0.75)

plt.axvspan(d.index[40-diff],d.index[40],color='cyan',alpha=0.5)

plt.axvspan(d.index[80-diff],d.index[80],color='red',alpha=0.5)

plt.axvspan(d.index[120],d.index[-1],color='green',alpha=0.5)


oldest_crack_sums=d.loc[(d.index>d.index[40-diff]) & (d.index<d.index[40])]

old_crack_sums=d.loc[(d.index>d.index[80-diff]) & (d.index<d.index[80])]

new_crack_sums=d.loc[d.index>d.index[120]]


#Fold-difference in mean between the two regimes.


old_crack_sums['Count'].mean()/float(new_crack_sums['Count'].mean())


#Two regimes.


oldest_crack=crack_pts[(crack_pts['Month']>(40-diff)) & (crack_pts['Month']<40)]

oldest_crack.columns=['longitude','latitude','time']

old_crack=crack_pts[(crack_pts['Month']>(80-diff)) & (crack_pts['Month']<80)]

old_crack.columns=['longitude','latitude','time']

new_crack=crack_pts[crack_pts['Month']>120]

new_crack.columns=['longitude','latitude','time']    