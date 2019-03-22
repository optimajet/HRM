import React, { Component } from 'react'
import { API } from './../../../scripts/optimajet-app.js'
import BigCalendar from 'react-big-calendar';
import moment from 'moment';

export default class Calendar extends Component {
    constructor(props) {
        super(props);
        this.state = {
            date: new Date(),
            events: []
        }

        BigCalendar.momentLocalizer(moment);
        this.reload();
    }

    render() {
        var title = "Work Calendar";
        if (DWKitLang != undefined && DWKitLang.forms != undefined &&
            DWKitLang.forms.WorkCalendar != undefined &&
            DWKitLang.forms.WorkCalendar.title != undefined)
            title = DWKitLang.forms.WorkCalendar.title;
        return <div>
            <h1>{title}</h1>
            <div style={{ height: "900px" }}>
                <BigCalendar
                    events={this.state.events}
                    startAccessor='start'
                    endAccessor='end'
                    date={this.state.date}
                    popup={true}
                    views={['month']}
                    type='month'
                    getDrilldownView={(targetDate, currentViewName, configuredViewNames) => {
                        return null;
                    }}
                    onSelectEvent={this.onSelectEvent.bind(this)}
                    onNavigate={this.onNavigate.bind(this)}
                    eventPropGetter={this.eventStyleGetter.bind(this)}
                />
            </div>
        </div>;
    }

    eventStyleGetter(event) {
        var backgroundColor;
        var style = {};
        if (event.form == "businesstrip") {
            style.backgroundColor = '#DBE5FF';
            style.color = style.borderLeftColor = '#4680FF';
            style.borderLeftWidth = '5px';
            style.borderLeftStyle = 'outset';
        }
        else if (event.form == "sickleave") {
            style.backgroundColor = '#FFE0E6';
            style.color = style.borderLeftColor = '#FB607F';
            style.borderLeftWidth = '5px';
            style.borderLeftStyle = 'outset';
        }
        else if (event.form == "vacation") {
            style.backgroundColor = '#FFF1DC';
            style.color = style.borderLeftColor = '#FEB64D';
            style.borderLeftWidth = '5px';
            style.borderLeftStyle = 'outset';
        }

        return {
            style: style
        };
    }
    

    onSelectEvent(event, e) {
        if (event.id == this.state.selectEventId) {
            API.redirectToForm(event.form, event.id)
        }
        else {
            this.setState({
                selectEventId: event.id,
                selectEventDate: new Date()
            });
        }
    }

    onNavigate(date) {
        this.state.date = date;
        this.reload();
        this.forceUpdate();
    }

    reload() {
        let url = '/report/workcalendar';
        let dateFrom = moment(this.state.date).add(-1, 'months');
        let dateTo = moment(this.state.date).add(1, 'months');
        url += '?datefrom=' + dateFrom.format('YYYY-MM-DD');
        url += '&dateto=' + dateTo.format('YYYY-MM-DD');

        let me = this;
        Pace.start();
        fetch(url, {
            credentials: 'same-origin'
        }).then(function (response) {
            Pace.stop();
            return response.json();
        })
        .then(function (events) {
            me.setState({
                events: events,
                selectEventId: undefined,
                selectEventDate: undefined
            });
        })
            .catch(function (error) {
            Pace.stop();
            alertify.error(error.message);
        });
    }
}