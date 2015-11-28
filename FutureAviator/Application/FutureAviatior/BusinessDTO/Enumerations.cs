using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public enum DBMethod
    {
        Add = 1,
        Update = 2,
        Delete = 3
    }
    public enum ApplicationLanguages
    {
        en = 1,
        ar = 2
    }
    public enum LanguageContentType
    {
        CountryName = 1,
        IndustryName = 2,
        JobTitle = 3,
        JobDescription = 4,
        EventName = 5,
        EventDesc = 6,
        ContactCustName = 7,
        ContactCustProject = 8,
        ContactCustMessage = 9,
        StoryCustName = 10,
        StoryCustDesignation = 11,
        StoryContent = 12,
        CMSSectionName = 13,
        CMSSectionText = 14,
        GalleryCategoryTitle = 15,
        GalleryCategoryDescription = 16,
        HomeSliderTitle = 17,
        HomeSliderSubTitle = 18,
        HomeSliderButtonText = 19,
        NewsSourceName = 20,
        NewsTitle = 21,
        NewsDescription = 22,
        ContentImageBoxTitle = 23,
        ContentImageBoxDescription = 24,
        PressReleaseHeader = 25,
        PressReleaseContent = 26,
        PrivacyPolicyContent = 27
    }

    public enum UserType
    {
        Administrator = 1,
        User = 2
    }
    public enum NotificationType
    {
        UserAppliedForJobNotificationForAdmin = 1,
        UserAppliedForJobNotificationForUser = 2
    }

    public enum CMSSectionTypes
    {
        ABOUTUS = 1,
        WHYCHOOSEUS = 2,
        WHATWEDO = 3,
        HOWDOWEWORK = 4,
        JOBSEARCHHEADER = 5,
        TRAININGCOURSES = 6,
        SERVICES = 7,
        INTERNATIONAL_AVIATION_OVERVIEW = 8,
        WHY_HAVE_A_CAREER_IN_AVIATION_1 = 9,
        INTRODUCTION_TO_GCAA = 10,
        UAE_OVERVIEW_AND_EMIRATIZATION = 11,
        INTERVIEW_TECHNIQUES_1 = 12,
        INTERVIEW_TECHNIQUES_2 = 13,
        PERSONAL_DETAILS = 14,
        EDUCATION_AND_QUALIFICATIONS = 15,
        WORK_EXPERIENCE = 16,
        INTERESTS_AND_ACHIEVEMENTS = 17,
        WHY_HAVE_A_CAREER_IN_AVIATION_2 = 18,
        WHY_HAVE_A_CAREER_IN_AVIATION_HEADER = 19,
        SKILLS = 20,
        REFERENCES = 21,
        CAREER_HEADER = 22,
        NATIONAL_CAREER_HEADER = 23,
        NATIONAL_CAREER_CONTENT = 24,
        EDUCATION_HEADER = 25,
        UAE_STUDY = 26,
        INTERNATIONAL_STUDY = 27,
        MEDIA_HEADER = 28,
        PRESS_RELEASES = 29,
        EVENTS = 30,
        TIPS_ADVICE_HEADER = 31,
        LOCATION_MAP = 32
    }
    public enum FileUploadType
    {
        GalleryCategoryImage = 1,
        GalleryImage = 2,
        HomeSliderImage = 3,
        NewsImage = 4,
        ContentBoxImage = 5
    }
    public enum UINotificationType
    {
        Success = 1,
        Error = 2,
        Notify = 3,
        Script = 4
    }
    public enum ImageContentBoxType
    {
        Carrers = 1,
        NationalCarrers = 2,
        UAEStudy = 3,
        InternationalStudy = 4
    }
    public enum BoxContentType
    {
        Detail = 1,
        Link = 2
    }
}
