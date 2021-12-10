import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {HttpClientModule} from "@angular/common/http";
import {AuthorizationModule} from "../../pages/authorization/authorization.module";
import {RouterModule} from "@angular/router";
import { ToolbarComponent } from './toolbar/toolbar.component';

//Material
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatIconModule } from '@angular/material/icon';
import { MatToolbarModule } from '@angular/material/toolbar';




@NgModule({
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    AuthorizationModule,
    RouterModule,

    MatSidenavModule,
    MatIconModule,
    MatToolbarModule
  ],
  exports:[
    MatSidenavModule,
    MatIconModule,
    MatToolbarModule,
  ],
  declarations: [
    AppComponent,
    ToolbarComponent
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
