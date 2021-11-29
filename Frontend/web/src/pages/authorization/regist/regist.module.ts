import { NgModule } from '@angular/core';
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {CommonModule} from "@angular/common";
import {FormRegistComponent} from "./form-regist/form-regist.component";
import {RouterModule} from "@angular/router";
import {registRoutes} from "./regist.routes";

@NgModule({
  imports: [
    RouterModule.forRoot(registRoutes),
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  declarations:[
    FormRegistComponent,
  ],
  exports:[
    RouterModule,
  ]
})
export class RegistModule { }
