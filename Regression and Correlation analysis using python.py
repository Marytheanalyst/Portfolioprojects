#import libraries

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import matplotlib
plt.style.use('ggplot')
from matplotlib.pyplot import figure
pd.options.mode.chained_assignment = None
desired_width = 320
pd.set_option('display.width', desired_width)
np.set_printoptions(linewidth=desired_width)
pd.set_option('display.max_columns', None)

# import data
data = pd.read_csv(r"C:\Users\GODFREY\Downloads\moviesdata.csv", encoding="ISO-8859-1")
print(data.head().to_string())

#Understand the data
print(data.head())
print(data.tail())
print(data.shape)
print(data.columns)
print(data.describe())
print(data.dtypes)
print(data['year'].value_counts())

# #Data Preparation
print(data.isnull().sum())
print(data.dropna())
print(data.loc[data.duplicated()])
# Test for outliers

data.boxplot(column=['gross'])
plt.show()
Order in ascending order
print(data.sort_values(by=['gross'], inplace=False, ascending=False))

# Regression analysis
sns.regplot(x="gross", y="budget", data=data)
plt.show()

sns.regplot(x="score", y="gross", data=data)
plt.show()

#Correlation between variables
print(data.corr(method = 'pearson',numeric_only=True))

correlation_matrix = data.corr(numeric_only=True)
sns.heatmap(correlation_matrix, annot = True)
plt.title("Correlation matrix for Numeric Features")
plt.xlabel("Movie features")
plt.ylabel("Movie features")
plt.show()

#sorting for maximum correlation
corr_pairs = correlation_matrix.unstack()
print(corr_pairs)
sorted_pairs = corr_pairs.sort_values(kind="quicksort")
print(sorted_pairs)
strong_pairs = sorted_pairs[abs(sorted_pairs) > 0.5]
print(strong_pairs)

# conclusion
## There is a high correlation between gross earnings of a film and budget
## There is a high correlation between gross earnings and votes

# Top 10 companies by gross revenue
CompanyGrossSum = data.groupby('company')[["gross"]].sum()
CompanyGrossSumSorted = CompanyGrossSum.sort_values('gross', ascending = False)[:15]
CompanyGrossSumSorted = CompanyGrossSumSorted['gross'].astype('int64')
print(CompanyGrossSumSorted)

sns.swarmplot(x="rating", y="gross", data=data)
plt.show()

print(data.groupby(['year'])[['gross', 'budget']].sum().plot())
plt.show()


