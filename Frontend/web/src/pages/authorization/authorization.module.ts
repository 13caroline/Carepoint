import {NgModule} from '@angular/core';
import {LoginModule} from "./login/login.module";
import {RegistModule} from "./regist/regist.module";
import { AuthorizationComponent } from './authorization.component';
import {RouterModule} from "@angular/router";
import {authorizationRoutes} from "./authorization.routes";

@NgModule({
  imports: [
    LoginModule,
    RegistModule,
    RouterModule.forRoot(authorizationRoutes),
  ],
  declarations: [
    AuthorizationComponent,
  ],
  exports:[
    RouterModule
  ]
})
export class AuthorizationModule {
}
