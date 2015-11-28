using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_Events : CoreEntity
    {

        public int AddNewAdminEvent(Event newEvent, BusinessDTO.ApplicationLanguages appLanguage, string eventEnglishName, string eventArabicName, string latitude, string longitude)
        {
            try
            {
                //event name//
                long EventNameTrsID = DBHelper.GetUniqueID();
                newEvent.EventName = EventNameTrsID;

                ////event description//
                //long EventDescTrsID = DBHelper.GetUniqueID();
                //eventDetails.EventDesc = EventDescTrsID;

                DBHelper.AddLanguageContent(EventNameTrsID, eventEnglishName, eventArabicName, BusinessDTO.LanguageContentType.EventName);
                //DBHelper.AddLanguageContent(EventDescTrsID, eventEnglishDesc, eventArabicDesc, BusinessDTO.LanguageContentType.EventDesc);


                Database.Events.Add(newEvent);
                int eventAdded = Database.SaveChanges();

                if (eventAdded > 0)
                {
                    EventLocation newLocation = new EventLocation();
                    newLocation.EventID = newEvent.ID;
                    newLocation.Name = newEvent.Venue;
                    if(latitude != "")
                        newLocation.Latitude = Convert.ToDecimal(latitude);
                    if(longitude != "")
                        newLocation.Longitude = Convert.ToDecimal(longitude);
                    newLocation.Description = newEvent.Venue;

                    Database.EventLocations.Add(newLocation);
                    return Database.SaveChanges();
                }
                else
                    throw new Exception("Failed to add new event details.");
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public int UpdateEventDetails(Event eventDetails, BusinessDTO.ApplicationLanguages appLanguage, string eventEnglishName, string eventArabicName, string latitude, string longitude)
        {
            try
            {
                if(eventDetails.ID == 0)
                {
                    ExceptionLogger.Logger.WriteErrorLog(new Exception("Event ID invalid."));
                    return 0;
                }
                Event currentEvent = Database.Events.Find(eventDetails.ID);

                //event name//
                long EventNameTrsID = DBHelper.GetUniqueID();
                currentEvent.EventName = EventNameTrsID;


                DBHelper.AddLanguageContent(EventNameTrsID, eventEnglishName, eventArabicName, BusinessDTO.LanguageContentType.EventName);


                currentEvent.UpdateDate = eventDetails.UpdateDate;
                currentEvent.UpdateBy = eventDetails.UpdateBy;

                //new fields//
                currentEvent.EventFromDate = eventDetails.EventFromDate;
                currentEvent.EventToDate = eventDetails.EventToDate;
                if (eventDetails.FileNameArabic != null)
                    currentEvent.FileNameArabic = eventDetails.FileNameArabic;
                if (eventDetails.FileNameEnglish != null)
                    currentEvent.FileNameEnglish = eventDetails.FileNameEnglish;
                currentEvent.Venue = eventDetails.Venue;

                Database.Entry(currentEvent).State = System.Data.Entity.EntityState.Modified;
                //int iRetVal = Database.SaveChanges();

                EventLocation newLoc = Database.EventLocations.Where(e => e.EventID == eventDetails.ID).FirstOrDefault();
                newLoc.Latitude = latitude == "" ? 0 : Convert.ToDecimal(latitude);
                newLoc.Longitude = longitude == "" ? 0 : Convert.ToDecimal(longitude);
                newLoc.Name = eventDetails.Venue;
                newLoc.Description = eventDetails.Venue;

                Database.Entry(newLoc).State = System.Data.Entity.EntityState.Modified;

                return Database.SaveChanges();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public int DeleteEvent(int eventID, long UserID)
        {
            try
            {
                if (eventID == 0)
                {
                    ExceptionLogger.Logger.WriteErrorLog(new Exception("Event ID invalid."));
                    return 0;
                }
                Event currentEvent = Database.Events.Find(eventID);

                currentEvent.Status = "D";
                currentEvent.DeletedOn = DateTime.Today;
                currentEvent.DeletedBy = UserID;

                Database.Entry(currentEvent).State = System.Data.Entity.EntityState.Modified;
                return Database.SaveChanges();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public List<EventResult> GetEvents(BusinessDTO.ApplicationLanguages appLanguage, DateTime eventFromDate)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<EventResult> events = new List<EventResult>();
                
                events = (from ev in Database.Events
                                            join lEventName in Database.LanguageContents on ev.EventName equals lEventName.TranslationID
                                            join location in Database.EventLocations on ev.ID equals location.EventID 
                                            where (lEventName.ContentTypeID == (int)LanguageContentType.EventName)
                                            && (lEventName.LanguageCode == lang)
                                            && ev.Status == "A" && ev.EventFromDate == eventFromDate
                                            select new EventResult
                                            {
                                                EventID = ev.ID,
                                                EventFromDate = ev.EventFromDate,
                                                EventToDate = ev.EventToDate,
                                                EventName = lEventName.LanguageContent1,
                                                EventVenue = ev.Venue,
                                                Latitude = location.Latitude,
                                                Longitude = location.Longitude,
                                                EnglishFileName = ev.FileNameEnglish,
                                                ArabicFileName = ev.FileNameArabic,
                                                DetailType = ev.DetailType,
                                                ExternalURL = ev.ExternalURL
                                            }).GroupBy(x => x.EventID).Select(group => group.FirstOrDefault()).ToList();
                
                return events;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<EventResult> GetEvents(BusinessDTO.ApplicationLanguages appLanguage, int eventID)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<EventResult> events = new List<EventResult>();

                events = (from ev in Database.Events
                          join lEventName in Database.LanguageContents on ev.EventName equals lEventName.TranslationID
                          join location in Database.EventLocations on ev.ID equals location.EventID
                          where (lEventName.ContentTypeID == (int)LanguageContentType.EventName)
                          && (lEventName.LanguageCode == lang)
                          && ev.Status == "A" && ev.ID == eventID
                          select new EventResult
                          {
                              EventID = ev.ID,
                              EventFromDate = ev.EventFromDate,
                              EventToDate = ev.EventToDate,
                              EventName = lEventName.LanguageContent1,
                              EventVenue = ev.Venue,
                              Latitude = location.Latitude,
                              Longitude = location.Longitude,
                              EnglishFileName = ev.FileNameEnglish,
                              ArabicFileName = ev.FileNameArabic,
                              DetailType = ev.DetailType,
                              ExternalURL = ev.ExternalURL
                          }).GroupBy(x => x.EventID).Select(group => group.FirstOrDefault()).ToList();

                return events;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }


        public List<EventResult> GetEvents(BusinessDTO.ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<EventResult> events = new List<EventResult>();

                events = (from ev in Database.Events
                          join lEventName in Database.LanguageContents on ev.EventName equals lEventName.TranslationID
                          join location in Database.EventLocations on ev.ID equals location.EventID
                          where (lEventName.ContentTypeID == (int)LanguageContentType.EventName)
                          && (lEventName.LanguageCode == lang)
                          && ev.Status == "A"
                          select new EventResult
                          {
                              EventID = ev.ID,
                              EventFromDate = ev.EventFromDate,
                              EventToDate = ev.EventToDate,
                              EventName = lEventName.LanguageContent1,
                              EventVenue = ev.Venue,
                              Latitude = location.Latitude,
                              Longitude = location.Longitude,
                              EnglishFileName = ev.FileNameEnglish,
                              ArabicFileName = ev.FileNameArabic,
                              DetailType = ev.DetailType,
                              ExternalURL = ev.ExternalURL
                          }).GroupBy(x => x.EventID).Select(group => group.FirstOrDefault()).ToList();

                return events;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public int AddEventAttendance(int eventID, string attendanceType, long userID)
        {
            try
            {
                EventAttendance attendance = new EventAttendance();
                attendance.EventID = eventID;
                attendance.AttendanceType = attendanceType;
                attendance.UserID = userID;
                attendance.RegisteredOn = DateTime.Now;
                Database.EventAttendances.Add(attendance);
                return Database.SaveChanges();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }
    }
}
