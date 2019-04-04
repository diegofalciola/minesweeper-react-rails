import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import { Match } from '../components/Match/match';
import { Component } from 'react';
import React from 'react';
import { withLayout } from '../components/layout';

export class Routes extends React.Component {
    public render() {
        return  (
          <Router>
            <Switch>
              <Route exact path="/" component={ () =>  withLayout(Match) } />
            </Switch>
          </Router>
        )
      }
}