import { Component, OnInit } from '@angular/core';
import {UserLogin} from '../api/user-login';

@Component({
  selector: 'app-login',
  templateUrl: './form-login.component.html',
  styleUrls: ['./form-login.component.css']
})
export class FormLoginComponent implements OnInit {
  login: UserLogin;
  constructor() { }

  ngOnInit(): void {

  }

}
