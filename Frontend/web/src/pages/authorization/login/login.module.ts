import { NgModule } from '@angular/core';
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {CommonModule} from "@angular/common";
import {FormLoginComponent} from "./form-login/form-login.component";
import {RouterModule} from "@angular/router";
import {loginRoutes} from "./login.routes";

@NgModule({
  imports: [
    RouterModule.forRoot(loginRoutes),
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  declarations:[
    FormLoginComponent
  ],
  exports:[
    RouterModule
  ]
})
export class LoginModule { }
