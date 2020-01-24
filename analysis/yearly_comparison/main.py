import flask
import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output

import pandas as pd
import pandas_gbq

server = flask.Flask(__name__)

query = \
    """
    SELECT
        year,
        cesa_num,
        ROUND(SUM(assignment_fte),2) AS equivalent_fte,
        ROUND(AVG(EXTRACT(year FROM CURRENT_DATE()) - birth_year),2) AS age
    FROM
        `wi-dpi-010.Merged.assignment_table_2015_newer`
    WHERE
        cesa_num IS NOT NULL
    GROUP BY
        year,
        cesa_num
    ORDER BY
        1,
        2
    """

df = pandas_gbq.read_gbq(query, dialect='standard', progress_bar_type=None)

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(
    __name__,
    server=server
)

df[['year', 'equivalent_fte', 'age']] = \
    df[['year', 'equivalent_fte', 'age']].apply(pd.to_numeric)

app.layout = html.Div([
    dcc.Graph(id='graph-with-slider'),
    dcc.Slider(
        id='year-slider',
        min=df['year'].min(),
        max=df['year'].max(),
        value=df['year'].min(),
        marks={str(year): str(year) for year in df['year'].unique()},
        step=None
    )
])

@app.callback(
    Output('graph-with-slider', 'figure'),
    [Input('year-slider', 'value')])
def update_figure(value):
    filtered_df = df[df.year == value]
    traces = []
    for i in filtered_df.cesa_num.unique():
        df_by_cesa = filtered_df[filtered_df['cesa_num'] == i]
        traces.append(dict(
            x=df_by_cesa['age'],
            y=df_by_cesa['equivalent_fte'],
            text=df_by_cesa['cesa_num'],
            mode='markers',
            opacity=0.7,
            marker={
                'size': 15,
                'line': {'width': 0.5, 'color': 'white'}
            },
            name=i
        ))

    return {
        'data': traces,
        'layout': dict(
            xaxis={'title': 'Age', 'range': [35, 51]},
            yaxis={'title': 'Equivalent FTE', 'range': [0, 20000]},
            margin={'l': 40, 'b': 40, 't': 10, 'r': 10},
            legend={'x': 0, 'y': 1},
            hovermode='closest',
            transition={'duration': 500},
        )
    }

if __name__ == '__main__':
    app.run_server(debug=True)
