import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';
import {UserRegist} from '../api/user-regist';

@Component({
  selector: 'app-regist',
  templateUrl: './form-regist.component.html',
  styleUrls: ['./form-regist.component.css']
})
export class FormRegistComponent implements OnInit {

  registForm: FormGroup;
  submitted = false;
  userRegist: UserRegist | undefined;
  constructor(
    private formBuilder: FormBuilder
  ) { }

  ngOnInit(): void {
    this.registForm = this.formBuilder.group({
      name: ['', Validators.required, Validators.maxLength(60)],
      email: ['', Validators.required],
      password : ['', Validators.required],
      phoneNumber : ['', Validators.required],
      qualifications : ['', Validators.required],
      location: ['', Validators.required],
      radiusActivity : ['', Validators.required],
      categories : ['', Validators.required],
      hourPayment : ['', Validators.required],
      description : ['', Validators.required],
    });

  }


  get f() { return this.registForm.controls; }


}
