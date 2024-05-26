class EventsListModel {
  int? responseCode;
  String? status;
  String? message;
  Data? data;

  EventsListModel({this.responseCode, this.status, this.message, this.data});

  EventsListModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userCountry;
  List<Types>? types;
  int? totalEvents;
  List<Events>? events;

  Data({this.userCountry, this.types, this.totalEvents, this.events});

  Data.fromJson(Map<String, dynamic> json) {
    userCountry = json['user_country'];
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(new Types.fromJson(v));
      });
    }
    totalEvents = json['total_events'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_country'] = this.userCountry;
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    data['total_events'] = this.totalEvents;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Types {
  int? id;
  String? name;

  Types({this.id, this.name});

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Events {
  int? eventManagementId;
  String? eventCode;
  String? artistName;
  String? venue;
  String? title;
  String? thumbnail;
  String? ticketBookingStart;
  String? ticketBookingEnd;
  String? dateOfEvent;
  String? endDateOfEvent;
  String? paymentUrl;
  String? eventUrl;
  String? paymentUrlStatus;
  List<Category>? category;
  String? eventStatus;

  Events(
      {this.eventManagementId,
        this.eventCode,
        this.artistName,
        this.venue,
        this.title,
        this.thumbnail,
        this.ticketBookingStart,
        this.ticketBookingEnd,
        this.dateOfEvent,
        this.endDateOfEvent,
        this.paymentUrl,
        this.eventUrl,
        this.paymentUrlStatus,
        this.category,
        this.eventStatus});

  Events.fromJson(Map<String, dynamic> json) {
    eventManagementId = json['event_management_id'];
    eventCode = json['event_code'];
    artistName = json['artist_name'];
    venue = json['venue'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    ticketBookingStart = json['ticket_booking_start'];
    ticketBookingEnd = json['ticket_booking_end'];
    dateOfEvent = json['date_of_event'];
    endDateOfEvent = json['end_date_of_event'];
    paymentUrl = json['payment_url'];
    eventUrl = json['event_url'];
    paymentUrlStatus = json['payment_url_status'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    eventStatus = json['event_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_management_id'] = this.eventManagementId;
    data['event_code'] = this.eventCode;
    data['artist_name'] = this.artistName;
    data['venue'] = this.venue;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['ticket_booking_start'] = this.ticketBookingStart;
    data['ticket_booking_end'] = this.ticketBookingEnd;
    data['date_of_event'] = this.dateOfEvent;
    data['end_date_of_event'] = this.endDateOfEvent;
    data['payment_url'] = this.paymentUrl;
    data['event_url'] = this.eventUrl;
    data['payment_url_status'] = this.paymentUrlStatus;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    data['event_status'] = this.eventStatus;
    return data;
  }
}

class Category {
  int? seatCategoryId;
  String? name;
  int? perSeatTos;
  String? seatBooked;
  String? totalSeat;
  int? availableSeatForBooking;

  Category(
      {this.seatCategoryId,
        this.name,
        this.perSeatTos,
        this.seatBooked,
        this.totalSeat,
        this.availableSeatForBooking});

  Category.fromJson(Map<String, dynamic> json) {
    seatCategoryId = json['seat_category_id'];
    name = json['name'];
    perSeatTos = json['per_seat_tos'];
    seatBooked = json['seat_booked'];
    totalSeat = json['total_seat'];
    availableSeatForBooking = json['available_seat_for_booking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seat_category_id'] = this.seatCategoryId;
    data['name'] = this.name;
    data['per_seat_tos'] = this.perSeatTos;
    data['seat_booked'] = this.seatBooked;
    data['total_seat'] = this.totalSeat;
    data['available_seat_for_booking'] = this.availableSeatForBooking;
    return data;
  }
}
