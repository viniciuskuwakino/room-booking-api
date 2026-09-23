import { BaseEntity, BaseEntityProps } from "./base-entity.js";

export interface UserProps extends BaseEntityProps {
  name: string;
  email: string;
  password: string;
}

export class User extends BaseEntity {

  private _name: string;
  private _email: string;
  private _password: string;

  constructor(data: UserProps) {
    super(
      data.id,
      data.createdAt,
      data.updatedAt
    );
    this._name = data.name;
    this._email = data.email;
    this._password = data.password;
  }
}