import {Categories} from './categories';

export interface UserRegist {
  name: string;
  email: string;
  password: string;
  phoneNumber: string;
  qualifications: File;
  location: string;
  radiusActivity?: number;
  categories: Categories[];
  hourPayment?: number;
  description: string;
}
