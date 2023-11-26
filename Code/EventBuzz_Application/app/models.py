from datetime import datetime
from sqlalchemy import create_engine, Column, ForeignKey, Integer, String, DateTime, Date, Enum, Text, Float, CheckConstraint, Time
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class User(Base):
    __tablename__ = 'Users'
    user_id = Column(Integer, primary_key=True, autoincrement=True, nullable=False)
    username = Column(String(255), nullable=False, unique=True)
    email = Column(String(255), nullable=False, unique=True)
    password = Column(String(255), nullable=False)
    first_name = Column(String(255))
    last_name = Column(String(255))
    date_of_birth = Column(Date)
    sex = Column(Enum('male', 'female', 'other'), nullable=False)
    phone_number = Column(String(20))
    street_no = Column(String(10))
    street_name = Column(String(255))
    unit_no = Column(String(10))
    city = Column(String(255))
    state = Column(String(255))
    zip_code = Column(String(10))
    country = Column(String(255))
    profile_picture_url = Column(Text)
    role = Column(Enum('admin', 'user', 'organizer'), nullable=False)
    status = Column(Enum('active', 'inactive'), nullable=False, default='active')

class EventCategory(Base):
    __tablename__ = 'EventCategories'
    category_name = Column(String(50), primary_key=True, nullable=False)
    description = Column(Text)

class Venue(Base):
    __tablename__ = 'Venues'
    venue_name = Column(String(255), primary_key=True, nullable=False)
    street_no = Column(String(10))
    street_name = Column(String(255))
    unit_no = Column(String(10))
    city = Column(String(255))
    state = Column(String(255))
    zip_code = Column(String(20))
    max_capacity = Column(Integer)
    contact_email = Column(String(255))
    contact_phone = Column(String(15))
    __table_args__ = (CheckConstraint('max_capacity > 0'),)

class Event(Base):
    __tablename__ = 'Events'
    event_name = Column(String(255), primary_key=True, nullable=False)
    event_description = Column(Text)
    event_date = Column(DateTime)
    event_time = Column(Time)
    event_status = Column(Enum('scheduled', 'cancelled', 'completed'), nullable=False, default='scheduled')
    event_image_url = Column(String(255))
    category_name = Column(String(50), ForeignKey('EventCategories.category_name', onupdate='CASCADE', ondelete='SET NULL'))
    venue_name = Column(String(255), ForeignKey('Venues.venue_name', onupdate='CASCADE', ondelete='SET NULL'))
    category = relationship('EventCategory')
    venue = relationship('Venue')

class Order(Base):
    __tablename__ = 'Orders'
    order_id = Column(Integer, primary_key=True, autoincrement=True, nullable=False)
    order_date = Column(DateTime, default=datetime.utcnow)
    payment_type = Column(Enum('credit_card', 'debit_card', 'paypal', 'other'), nullable=False)
    payment_status = Column(Enum('paid', 'pending', 'failed'), nullable=False, default='pending')
    total_amount = Column(Float, nullable=False, default=0)
    user_id = Column(Integer, ForeignKey('Users.user_id', onupdate='CASCADE', ondelete='SET NULL'))
    event_name = Column(String(255), ForeignKey('Events.event_name', onupdate='CASCADE', ondelete='SET NULL'))
    user = relationship('User')
    event = relationship('Event')
    __table_args__ = (CheckConstraint('total_amount >= 0'),)

class Ticket(Base):
    __tablename__ = 'Tickets'
    ticket_id = Column(Integer, primary_key=True, autoincrement=True)
    ticket_price = Column(Float, nullable=False)
    ticket_quantity = Column(Integer, nullable=False)
    start_sale_date = Column(DateTime)
    end_sale_date = Column(DateTime)
    event_name = Column(String(255), ForeignKey('Events.event_name', onupdate='CASCADE', ondelete='SET NULL'))
    order_id = Column(Integer, ForeignKey('Orders.order_id', onupdate='CASCADE', ondelete='CASCADE'))
    event = relationship('Event')
    order = relationship('Order')
    __table_args__ = (CheckConstraint('ticket_price >= 0'), CheckConstraint('ticket_quantity >= 0'),)

class Review(Base):
    __tablename__ = 'Reviews'
    rating = Column(Integer, nullable=False)
    comment = Column(Text)
    review_date = Column(DateTime, nullable=False, default=datetime.utcnow)
    user_id = Column(Integer, ForeignKey('Users.user_id', onupdate='CASCADE', ondelete='CASCADE'))
    event_name = Column(String(255), ForeignKey('Events.event_name', onupdate='CASCADE', ondelete='CASCADE'))
    user = relationship('User')
    event = relationship('Event')
    __table_args__ = (CheckConstraint('rating BETWEEN 1 AND 5'),)

class Sponsor(Base):
    __tablename__ = 'Sponsors'
    sponsor_name = Column(String(255), primary_key=True, nullable=False)
    description = Column(Text)
    website_url = Column(String(255))
    logo_url = Column(String(255))
    contact_email = Column(String(255))
    contact_phone = Column(String(15))
    total_sponsorship_amount = Column(Float, default=0)
    __table_args__ = (CheckConstraint('total_sponsorship_amount >= 0'),)

class Organiser(Base):
    __tablename__ = 'Organisers'
    organiser_name = Column(String(255), primary_key=True, nullable=False)
    description = Column(Text)
    logo_url = Column(String(255))
    contact_email = Column(String(255))
    contact_phone = Column(String(15))

class Notification(Base):
    __tablename__ = 'Notifications'
    notification_id = Column(Integer, primary_key=True, autoincrement=True)
    notification_text = Column(Text)
    notification_date = Column(DateTime, nullable=False, default=datetime.utcnow)
    event_name = Column(String(255), ForeignKey('Events.event_name', onupdate='CASCADE', ondelete='CASCADE'))
    event = relationship('Event')

class UserNotification(Base):
    __tablename__ = 'Notifications_SendTo_Users'
    user_id = Column(Integer, ForeignKey('Users.user_id', onupdate='CASCADE', ondelete='CASCADE'), primary_key=True)
    notification_id = Column(Integer, ForeignKey('Notifications.notification_id', onupdate='CASCADE', ondelete='CASCADE'), primary_key=True)
    user = relationship('User')
    notification = relationship('Notification')

class UserEvent(Base):
    __tablename__ = 'Users_RegisterFor_Events'
    user_id = Column(Integer, ForeignKey('Users.user_id', onupdate='CASCADE', ondelete='CASCADE'), primary_key=True)
    event_name = Column(String(255), ForeignKey('Events.event_name', onupdate='CASCADE', ondelete='CASCADE'), primary_key=True)
    registration_date = Column(DateTime, default=datetime.utcnow)
    user = relationship('User')
    event = relationship('Event')

class EventSponsor(Base):
    __tablename__ = 'Events_FundedBy_Sponsors'
    event_name = Column(String(255), ForeignKey('Events.event_name', onupdate='CASCADE', ondelete='CASCADE'), primary_key=True)
    sponsor_name = Column(String(255), ForeignKey('Sponsors.sponsor_name', onupdate='CASCADE', ondelete='CASCADE'), primary_key=True)
    sponsorship_amount = Column(Float, nullable=False)
    sponsorship_date = Column(DateTime, nullable=False, default=datetime.utcnow)
    event = relationship('Event')
    sponsor = relationship('Sponsor')
    __table_args__ = (CheckConstraint('sponsorship_amount >= 0'),)

class EventOrganiser(Base):
    __tablename__ = 'Events_OrganisedBy_Organisers'
    event_name = Column(String(255), ForeignKey('Events.event_name', onupdate='CASCADE', ondelete='CASCADE'), primary_key=True)
    organiser_name = Column(String(255), ForeignKey('Organisers.organiser_name', onupdate='CASCADE', ondelete='CASCADE'), primary_key=True)
    organiser_role = Column(String(100))
    event = relationship('Event')
    organiser = relationship('Organiser')

# Add additional configurations and database initializations as needed
