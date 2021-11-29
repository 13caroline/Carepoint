import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {authorizationRoutes} from '../../pages/authorization/authorization.routes';
import {FormLoginComponent} from '../../pages/authorization/login/form-login/form-login.component';

export const routes: Routes = [

  {path: '', redirectTo: 'authorization', pathMatch: 'full'},
  ...authorizationRoutes
];
@NgModule({
  imports: [
    RouterModule.forRoot(routes),
  ],
  exports: [RouterModule],

})
export class AppRoutingModule {


}
