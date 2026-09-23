import { BaseEntity, BaseEntityProps } from "./base-entity.js";
import { RoomProps } from "./room.js";

export interface MeetingProps extends BaseEntityProps {
  startsAt: string;
  endsAt: string;
  room: RoomProps;
}

export class Meeting extends BaseEntity {
  
  private _startsAt: string; 
  private _endsAt: string; 
  private _room: RoomProps; 

  constructor(data: MeetingProps) {
    super(
      data.id,
      data.createdAt,
      data.updatedAt
    );
    this._startsAt = data.startsAt;
    this._endsAt = data.endsAt;
    this._room = data.room;
  }
}