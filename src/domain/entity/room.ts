import { BaseEntity, BaseEntityProps } from "./base-entity.js";

export interface RoomProps extends BaseEntityProps {
  name: string;
}

export class Room extends BaseEntity {

  private _name: string;

  constructor(data: RoomProps) {
    super(
      data.id,
      data.createdAt,
      data.updatedAt
    );
    this._name = data.name;
  }
}