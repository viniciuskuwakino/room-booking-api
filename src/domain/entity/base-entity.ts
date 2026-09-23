
export interface BaseEntityProps {
  id: string;
  createdAt: string;
  updatedAt: string;
}

export class BaseEntity {
  constructor(
    public _id: string,
    protected _createdAt: string,
    protected _updatedAt: string
  ) {}

  public getId() {
    return this._id;
  }

  public getCreatedAt() {
    return this._createdAt;
  }

  public getUpdatedAt() {
    return this._updatedAt;
  }
}