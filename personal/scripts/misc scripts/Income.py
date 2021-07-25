import csv
import numpy as np
import matplotlib.pyplot as plt #actually enables plotting

data_file="data.csv"
with open(data_file, 'r') as csvfile:
    reader=csv.DictReader(csvfile)
    data=list(reader)


##def dataset(path):
##    '''access single row at a time to conserve memory usage'''
##    with open(path, 'r') as csvfile:
##        reader=csv.DictReader(csvfile)
##        for row in reader:
##            yield row

def USdata():
    '''separate and analyze US data'''
    filter(lambda row:row["Country"]=="United States", dataset(data_file))

def dataset(path, country="United States"):
    '''extracts data from US'''
    with open(path, 'r') as csvfile:
        reader=csv.DictReader(csvfile)
        for row in filter(lambda row:row["Country"]==country, reader):
            yield row

def timeSeries(data, column):
    '''creates year based time series for given column'''
    for row in filter(lambda row:row[column], data):
        yield (int(row["Year"]), row[column])

def linechart(series, **kwargs):
    fig=plt.figure()
    ax=plt.subplot(111)
    for line in series:
        line=list(line)
        xvals=[v[0] for v in line]
        yvals=[v[1] for v in line]
        ax.plot(xvals, yvals)

    if 'ylabel' in kwargs:
        ax.set_ylabel(kwargs['ylabel'])

    if 'title' in kwargs:
        plt.title(kwargs['title'])
        
    if 'labels' in kwargs:
        ax.legend(kwargs.get('labels'))

        return fig

def percentIncomeShare(source):
    '''creates income chart'''
    columns=(
        "Top 10% income share", "Top 5% income share", "Top 1% income share",
        "Top 0.5% income share", "Top 0.1% income share",
        )
    source=list(dataset(source))
    return linechart([timeSeries(source,col) for col in columns], labels=columns,
                     title="US Income share", ylabel="Percentage")

def normalize(data):
    '''normalizes data set with timeseries input'''
    data=list(data)
    norm=np.array(list(d[1] for d in data), dtype="f8")
    mean=norm.mean()
    norm/=mean
    return zip((d[0] for d in data), norm)

def meanNormPercentIncomeShare(source):
    columns=(
        "Top 10% income share", "Top 5% income share", "Top 1% income share",
        "Top 0.5% income share", "Top 0.1% income share",
        )
    source=list(dataset(source))
    return linechart([normalize(timeSeries(source,col)) for col in columns],
                     labels=columns,
                     title="Mean Normalized US Percent Income Share",
                     ylabel="Percentage")
#meanNormPercentIncomeShare(data_file)

def delta(first, second):
    '''returns array of deltas'''
    firs=list(first)
    years=yrange(first)
    first=np.array(list(d[1] for d in first), dtype='f8')
    second=np.array(list(d[1] for d in second), dtype='f8')

#    if first.size!=second.size:
 #       first=np.insert(first, [0,0,0,0], [None,None,None,None])
    diff=first-second
    return zip(years,diff)

def yrange(data):
    '''range of years in dataset'''
    years=set()
    for row in data:
        if row[0] not in years:
            yield row[0]
            years.add(row[0])

def capitalGainsLift(source):
    '''computes capital gains lift in income ranges over time chart'''
    columns=(("Top 10% income share-including capital gains", "Top 10% income share"),
             ("Top 5% income share-including capital gains", "Top 5% income share"),
             ("Top 1% income share-including capital gains","Top 1% income share"),
             ("Top 0.5% income share-including capital gains","Top 0.5% income share"),
             ("Top 0.1% income share-including capital gains","Top 0.1% income share"),
             ("Top 0.05% income share-including capital gains","Top 0.05% income share"),
             )
    source=list(dataset(source))
    series=[delta(timeSeries(source, a), timeSeries(source,b)) for a,b in columns]
    return linechart(series, labels=list(col[1] for col in columns),
                     title="U.S Capital Gains Income Lift",
                     ylabel="Percentage Difference")

capitalGainsLift(data_file)



##def main(path):
##    data=[(row["Year"], float(row["Average income per tax unit"]))
##          for row in dataset(path, "Country", "United States")]
##    width=0.35
##    ind=np.arange(len(data))
##    fig=plt.figure()
##    ax=plt.subplot(111)
##    ax.bar(ind, list(d[1] for d in data))
##    ax.set_xticks(np.arange(0, len(data), 4))
##    ax.set_xticklabels(list(d[0] for d in data)[0::4], rotation=45)
##    ax.set_xlabel("Year")
##    ax.set_ylabel("Income in USD")
##    plt.title("U.S. Average Income 1913-2008")
##    plt.show()

plt.show()
