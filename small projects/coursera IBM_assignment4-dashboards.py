#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output
import pandas as pd
import plotly.graph_objs as go
import plotly.express as px

# Load the data using pandas
data = pd.read_csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DV0101EN-SkillsNetwork/Data%20Files/historical_automobile_sales.csv')

# Initialize the Dash app
app = dash.Dash(__name__)

# Set the title of the dashboard
app.title = "Automobile Sales Statistics Dashboard"

#---------------------------------------------------------------------------------
# Create the dropdown menu options
dropdown_options = [
    {'label':'Yearly Statistics', 'value':'Yearly Statistics'},
    {'label':'Recession Period Statistics', 'value':'Recession Period Statistics'}
]
# List of years 
year_list = [i for i in range(1980, 2024, 1)]
#---------------------------------------------------------------------------------------
# Create the layout of the app
app.layout = html.Div([
    #TASK 2.1 Add title to the dashboard
    html.H1(app.title,
    style={'textAlign':'center', 'color':'#503D36', 'font-size':24}),
    html.Div([#TASK 2.2: Add two dropdown menus
        html.Label("Select Statistics:"),
        dcc.Dropdown(
            id='dropdown-statistics',
            options=dropdown_options,
            value='Select Statistics',
            placeholder='Select a report type',
            style={'width':'60%', 'textAlign':'center', 'font-size':20}
        )
    ]),
    html.Div(dcc.Dropdown(
            id='select-year',
            options=[{'label':i, 'value':i} for i in year_list],
            value='Select year',
            style={'width':'60%', 'textAlign':'center', 'font-size':20}
        )),
    html.Div([#TASK 2.3: Add a division for output display
    html.Div(id='output-container', className='chart-grid', style={'display':'flex'})])
])
#TASK 2.4: Creating Callbacks
# Define the callback function to update the input container based on the selected statistics
@app.callback(
    Output(component_id='select-year', component_property='disabled'),
    Input(component_id='dropdown-statistics', component_property='value'))

def update_input_container(selected_statistics):
    if selected_statistics == 'Yearly Statistics': 
        return False
    else: 
        return True

#Callback for plotting
# Define the callback function to update the input container based on the selected statistics
@app.callback(
    Output(component_id='output-container', component_property='children'),
    [Input(component_id='dropdown-statistics', component_property='value'), 
     Input(component_id='select-year', component_property='value')])

def update_output_container(info_stats, info_year):
    if info_stats == 'Recession Period Statistics':
        # Filter the data for recession periods
        recession_data = data[data['Recession'] == 1]
        
#TASK 2.5: Create and display graphs for Recession Report Statistics
#Plot 1 Automobile sales fluctuate over Recession Period (year wise)
        # use groupby to create relevant data for plotting
        yearly_rec = recession_data.groupby('Year')['Automobile_Sales'].mean().reset_index()
        R_chart1 = dcc.Graph(
            figure=px.line(
                yearly_rec, 
                x='Year',
                y='Automobile_Sales',
                labels={"Automobile_Sales": "Average automobile sales"},
                title="Average Automobile Sales fluctuation over Recession Period")
                )

#Plot 2 Calculate the average number of vehicles sold by vehicle type       
        # use groupby to create relevant data for plotting
        average_sales = recession_data.groupby('Vehicle_Type')['Automobile_Sales'].mean().reset_index()
        R_chart2 = dcc.Graph(
            figure=px.bar(
                average_sales, 
                x='Vehicle_Type',
                y='Automobile_Sales',
                labels={
                "Vehicle_Type": "Vehicle type",
                "Automobile_Sales": "Average automobile sales"},
                title="Average number of vehicles sold by vehicle type")
                )
        
# Plot 3 Pie chart for total expenditure share by vehicle type during recessions
        # use groupby to create relevant data for plotting
        exp_rec = recession_data.groupby('Vehicle_Type')['Advertising_Expenditure'].sum().reset_index()
        R_chart3 = dcc.Graph(
            figure=px.pie(
                exp_rec,
                #labels=pd.unique(recession_data['Vehicle_Type']), 
                names='Vehicle_Type',
                values='Advertising_Expenditure',
                labels={
                "Vehicle_Type": "Vehicle type",
                "Advertising_Expenditure": "Total advertising expenditure"},
                #autopct='%1.f%%',
                title='Total expenditure share by vehicle type during recessions')
                )

# Plot 4 bar chart for the effect of unemployment rate on vehicle type and sales
        unempl = recession_data.groupby(['unemployment_rate','Vehicle_Type'])['Automobile_Sales'].mean().reset_index()
        unempl['rates'] = pd.cut(x=unempl['unemployment_rate'], bins=[2, 3.5, 4.5, 6], labels=['low', 'mid', 'high'])
        R_chart4  = dcc.Graph(
            figure=px.bar(
                unempl,
                x='rates',
                y='Automobile_Sales',
                color='Vehicle_Type',
                labels={
                "rates": "Unemployment rate category",
                "Automobile_Sales": "Mean automobbile sales",
                "Vehicle_Type": "Vehicle type"},
                title='Effect of unemployment rate on vehicle type and sales')
                )

        return [
            html.Div(className='chart-item', children=[R_chart1, R_chart2]),
            html.Div(className='chart-item', children=[R_chart3, R_chart4])
            ]

# TASK 2.6: Create and display graphs for Yearly Report Statistics
# Yearly Statistic Report Plots                             
    elif (info_year and info_stats=='Yearly Statistics') :
        yearly_data = data[data['Year'] == info_year]
                                                            
# Plot 1 Yearly Automobile sales using line chart for the whole period.
        yas = data.groupby('Year')['Automobile_Sales'].mean().reset_index()
        Y_chart1 = dcc.Graph(
            figure=px.line(
                yas, 
                x='Year',
                y='Automobile_Sales',
                labels={"Automobile_Sales": "Mean automobile sales"},
                title="Yearly Automobile sales")
                )
            
# Plot 2 Total Monthly Automobile sales using line chart.
        mas = yearly_data.groupby('Month')['Automobile_Sales'].mean().reset_index()
        mas['sorter'] = [4,8,12,2,1,7,6,3,5,11,10,9]
        mas.sort_values(by="sorter", axis=0, inplace=True)
        Y_chart2 = dcc.Graph(
            figure=px.line(
                mas, 
                x='Month',
                y='Automobile_Sales',
                labels={"Automobile_Sales": "Mean automobile sales"},
                title="Total Monthly Automobile sales in {}".format(info_year))
                )

# Plot bar chart for average number of vehicles sold during the given year
        avr_vdata = yearly_data.groupby('Vehicle_Type')['Automobile_Sales'].mean().reset_index()
        Y_chart3 = dcc.Graph(
            figure=px.bar(
                avr_vdata, 
                x='Vehicle_Type', 
                y='Automobile_Sales',
                labels={
                "Vehicle_Type": "Vehicle type",
                "Automobile_Sales": "Average automobile sales"},
                title='Average Vehicles Sold by Vehicle Type in the year {}'.format(info_year))
                )
        
# Total Advertisement Expenditure for each vehicle using pie chart
        exp_data = yearly_data.groupby('Vehicle_Type')['Advertising_Expenditure'].sum().reset_index()
        Y_chart4 = dcc.Graph(
            figure=px.pie(
                exp_data,
                names='Vehicle_Type', 
                values='Advertising_Expenditure',
                labels={
                "Vehicle_Type": "Vehicle type",
                "Advertising_Expenditure": "Total advertising expenditure"},
                title='Total Advertisement Expenditure for each Vehicle in {}'.format(info_year))
                )

#TASK 2.6: Returning the graphs for displaying Yearly data
        return [
            html.Div(className='chart-item', children=[Y_chart1, Y_chart2]),
            html.Div(className='chart-item', children=[Y_chart3, Y_chart4])
            ]
        
    else:
        return None

# Run the Dash app
if __name__ == '__main__':
    app.run_server(debug=True)