import { Route } from "react-router";

export default function configRoutes() {
    return (
        <Route component={MainLayout}>
          <Route path="/sign_up" component={RegistrationsNew} />
          <Route path="/sign_in" component={SessionsNew} />
    
          <Route path="/" component={AuthenticatedContainer} onEnter={_ensureAuthenticated}>
            <IndexRoute component={HomeIndexView} />
    
            <Route path="/boards/:id" component={BoardsShowView}>
              <Route path="cards/:id" component={CardsShowView}/>
            </Route>
          </Route>
        </Route>
      );
}