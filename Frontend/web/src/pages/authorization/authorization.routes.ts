import {Routes} from '@angular/router';
import {registRoutes} from './regist/regist.routes';
import {loginRoutes} from './login/login.routes';

export const authorizationRoutes: Routes = [

  {
    path: 'authorization',
    children : [
      ...registRoutes,
      ...loginRoutes
    ],
  },
]
;

