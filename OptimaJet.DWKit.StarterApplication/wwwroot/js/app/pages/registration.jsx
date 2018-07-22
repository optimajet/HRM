import React from 'react'
import { render } from 'react-dom'
import { DWKitForm } from "./../../../scripts/optimajet-form.js"

export default class Registration extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            data: {},
            hideControls: []
        }

        this.onLoad(props.inviteKey);
    }

    render(){
        let sectorprops = {
            eventFunc: this.eventHandler.bind(this)
        };

        let form = this.state.isCompelete ? "RegistrationComplete" : "Registration";

        return <DWKitForm {...sectorprops}  
              formName={form}
              modelurl= {"/ui/" + form}
              data={this.state.data} 
              errors={this.state.errors}
              hideControls={this.state.hideControls}
              dataChanged={this.dataChanged.bind(this)}
              className="dwkit-application-login" />;
    }

    dataChanged(form, { key, value }) {
        this.state.data[key] = value;
        this.CheckHideControls();
        this.forceUpdate();
    }

    CheckHideControls(){
        let cbDomain = this.state.data.cbDomain;
        if (cbDomain)
            this.state.hideControls = this.state.hideControls.filter(c => c != 'DomainLogin');
        else
            this.state.hideControls.push("DomainLogin");
        
        let cbCustom = this.state.data.cbCustom;
        if (cbCustom)
            this.state.hideControls = this.state.hideControls.filter(c => c != 'Login' && c != 'Password');
        else {
            this.state.hideControls.push("Login");
            this.state.hideControls.push("Password");
        }
    }

    eventHandler(args) {
        var me = this;
        if (Array.isArray(args.actions)){
            args.actions.forEach(function (a) {
                if (a === "save"){
                    me.onSave();
                }
                else if(a === "redirect"){
                    window.location = args.parameters["target"];
                }
            });
        }
        return false;
    }

    validate(){
        var res = true;
        var editrow = this.state.data;
        var msgRequiredField = "This field is required";
        this.state.errors = {};

        if(editrow.cbDomain == false && editrow.cbCustom == false){
            this.state.errors.cbDomain = true;
            this.state.errors.cbCustom = true;
            return false;
        }

        if(editrow.cbDomain){
             this.state.errors.DomainLogin = (editrow.DomainLogin == undefined || editrow.DomainLogin == "") ? msgRequiredField : undefined;
        }

        if(editrow.cbCustom){
            this.state.errors.Login = (editrow.Login == undefined || editrow.Login == "") ? msgRequiredField : undefined;
            this.state.errors.Password = (editrow.Password == undefined || editrow.Password == "") ? msgRequiredField : undefined;
        }

        res &= this.state.errors.DomainLogin == undefined && this.state.errors.Login == undefined && this.state.errors.Password == undefined;
        return res;
    }
    
    onSave(){
        if (this.validate() == false) {
            alertify.error("Check errors on this form!");
        }
        else {
            var me = this;
            var data = new Array();
            data.push({name:'key', value: this.props.inviteKey});

            if(this.state.data.cbCustom){
                data.push({name: 'Login', value: this.state.data.Login});
                data.push({name: 'Password', value: this.state.data.Password});
            }

            if(this.state.data.cbDomain){
                data.push({name: 'DomainLogin', value: this.state.data.DomainLogin});
            }

            $.ajax({
                url: "/account/registration",
                data: data,
                async: true,
                type: "post",
                success: function (response) {
                    if (response.success) {
                        me.setState({
                            isCompelete: true
                        });
                    }
                    else {
                        alertify.error(response.message);                      
                    }
                }
            });
        }
        this.forceUpdate();
    }

    onLoad(key) {
        var me = this;
        $.ajax({
            url: "/account/getinviteinfo?key=" + key,
            async: true,
            success: function (response) {
                if (response.success) {
                    let domainLogin = response.item.domainLogin;
                    let login = response.item.login;
                    let name = response.item.name;
                    me.state.data = {
                            cbCustom: login != undefined,
                            Login: login,
                            cbDomain: domainLogin != undefined,
                            DomainLogin: domainLogin,
                            Name: name
                    };
                    me.CheckHideControls();
                    me.forceUpdate();
                }
                else {
                    alertify.error(response.message);
                }
            }
        });
    }

     getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
}
