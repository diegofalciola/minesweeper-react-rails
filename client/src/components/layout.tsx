import React from 'react';
import { Link, withRouter, RouteComponentProps } from 'react-router-dom';

class Layout extends React.Component<RouteComponentProps<any>> {
    public render() {
        return (
            <div>
            <nav className="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
                <Link className="navbar-brand" to="/">Minesweeper</Link>
            </nav>

            <main role="main" className="container">
                { this.props.children }
            </main>
        </div>
        )
    }
}

const LayoutWithRouter = withRouter(Layout);

export function withLayout(Component: React.ComponentClass) {
    return (
        <LayoutWithRouter>
            <Component/>
        </LayoutWithRouter>
    )
}