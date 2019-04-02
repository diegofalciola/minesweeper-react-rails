import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import { Match } from '../components/Match/match';
import { Component } from 'react';
import React from 'react';

export class Routes extends React.Component {
    public render() {
        return  (
          <Router>
            <Switch>
              <Route exact path="/" component={ Match } />
            </Switch>
          </Router>
        )
      }
}