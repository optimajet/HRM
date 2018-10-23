import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { BrowserRouter, Switch, Route } from 'react-router-dom'
import { DWKitForm } from "./../../scripts/optimajet-form.js"
import {ApplicationRouter, NotificationComponent, FormContent, 
    FlowContent, Thunks, Store, Actions, API, StateBindedForm, SignalRConnector
} from './../../scripts/optimajet-app.js'
import Calendar from "./pages/calendar.jsx"

class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            pagekey: 0
        };
        
        let me = this;
        Store.dispatch(Thunks.userinfo.fetch(function (){
            me.forceUpdate();
        }));
        
        window.DWKitApp = this;
        window.DWKitApp.API = API;
        this.onFetchStarted();
    }
    
    render(){
        let sectorprops = {
            eventFunc: this.actionsFetch.bind(this),
            getAdditionalDataForControl: this.additionalFetch.bind(this, undefined)
        };
        
        let state = Store.getState();
        let user = state.app.user;
        if (user == undefined){
            user = {};
        }
        
        let currentEmployee = state.app.impersonatedUserId ? state.app.impersonatedUserId : user.id;
        
        return <div className="dwkit-application" key={this.state.pagekey}>
            <DWKitForm {...sectorprops} formName="header" modelurl="/ui/form/header" data={user} />
            <div className="dwkit-application-container">
                 <Provider store={Store}>
                    <div className="dwkit-application-menu">
                        <StateBindedForm {...sectorprops} formName="sidemenu" stateDataPath="app.sidemenu" modelurl="/ui/form/sidemenu" />
                    </div>
                 </Provider>
                   <div className="dwkit-application-basecontent">
                    <DWKitForm {...sectorprops} formName="top" data={{ currentEmployee: currentEmployee }} modelurl="/ui/form/top" />
                    <div class="dwkit-application-top"></div>
                    <div className="dwkit-application-content">
                        <Provider store={Store}>
                            <BrowserRouter>
                                <div className="dwkit-application-content-form">
                                    <ApplicationRouter onRefresh={this.onRefresh.bind(this)} />
                                    <NotificationComponent
                                        onFetchStarted={this.onFetchStarted.bind(this)}
                                        onFetchFinished={this.onFetchFinished.bind(this)} />
                                    <Switch>
                                        <Route path='/form' component={FormContent} />
                                        <Route path='/flow' component={FlowContent} />
                                        <Route exact path='/'>
                                            <FormContent formName="Dashboard" />
                                        </Route>
                                        <Route path='/page/workcalendar' component={Calendar} />
                                        <Route nomatch render={() => {
                                            //Hack for back button
                                            let pathname = window.location.pathname;
                                            if (pathname != undefined && pathname.toLowerCase().startsWith('/page'))
                                                return null;

                                            let url = window.location.href;
                                            window.location.href = url;
                                            return null;
                                        }} />
                                    </Switch>
                                </div>
                            </BrowserRouter>
                        </Provider>
                    </div>
                </div>
            </div>
            <DWKitForm {...sectorprops} formName="footer" modelurl="/ui/form/footer" />
        </div>;
    }

    onFetchStarted(){
        $('body').loadingModal({
            text: 'Loading...',
            animation: 'foldingCube',
            backgroundColor: '#1262E2'});
    }

    onFetchFinished(){
        $('body').loadingModal('destroy');
    }

    onRefresh(){
        this.onFetchStarted();
        Store.resetForm();
        this.setState({
            pagekey: this.state.pagekey + 1
        });
        SignalRConnector.Connect(Store);
    }

    actionsFetch(args){
        Store.dispatch(Thunks.form.executeActions(args));
    }

    additionalFetch(formName, controlRef, { startIndex, pageSize, filters, sort, model }, callback) {
        Store.dispatch(Thunks.additional.fetch({
                type: controlRef.props["data-buildertype"],
                formName, controlRef, startIndex, pageSize, filters, sort, callback
            }
        ));
    }
}

SignalRConnector.Connect(Store);

render(<App/>,document.getElementById('content'));


