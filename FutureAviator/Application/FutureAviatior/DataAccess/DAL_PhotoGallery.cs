using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_PhotoGallery : CoreEntity
    {
        public long AddPhotoToPhotoGallery(PhotoGallery photoGallery)
        {
            try
            {
                Database.PhotoGalleries.Add(photoGallery);
                Database.SaveChanges();
                return photoGallery.PhotoGalleryID;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }
        public bool UpdatePhotoToPhotoGallery(long PhotoGalleryID, PhotoGallery photoGallery)
        {
            try
            {
                PhotoGallery myGallery = Database.PhotoGalleries.Where(p => p.PhotoGalleryID == PhotoGalleryID).SingleOrDefault();
                if (myGallery != null)
                {
                    myGallery.IsActive = photoGallery.IsActive;
                    myGallery.PhotoGalleryCategoryID = photoGallery.PhotoGalleryCategoryID;
                    myGallery.PhotoPath = photoGallery.PhotoPath;
                    myGallery.UpdateBy = photoGallery.UpdateBy;
                    myGallery.UpdateDate = photoGallery.UpdateDate;
                    Database.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }

            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }

        public bool DeletePhotoToPhotoGallery(long PhotoGalleryID)
        {
            try
            {
                PhotoGallery myGallery = Database.PhotoGalleries.Where(p => p.PhotoGalleryID == PhotoGalleryID).SingleOrDefault();
                if (myGallery != null)
                {
                    Database.PhotoGalleries.Remove(myGallery);
                    Database.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }

            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }

        public PhotoGallery GetPhotoGalleryImageByID(long GalleryImageID)
        {
            try
            {
                return Database.PhotoGalleries.Where(p => p.PhotoGalleryID == GalleryImageID).SingleOrDefault();
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
        public GalleryResult GetPhotoGallery(ApplicationLanguages appLanguage, int GalleryCategoryID)
        {
            try
            {
                GalleryResult galleryResult = new GalleryResult();

                DAL_PhotoGalleryCategory dalPhotoGalleryCategory = new DAL_PhotoGalleryCategory();

                List<GalleryCategoryResult> galleryCategories = dalPhotoGalleryCategory.GetAllActivePhotoGalleryCategories(appLanguage, LanguageContentType.GalleryCategoryTitle);
                GalleryCategoryResult galleryCategory = galleryCategories.Where(p => p.PhotoGalleryCategoryID == GalleryCategoryID).SingleOrDefault();
                if (galleryCategory != null)
                {
                    galleryResult.GalleryDescription = galleryCategory.CategoryDescription;
                    galleryResult.GalleryTitle = galleryCategory.CategoryTitle;
                }
                List<GallaryPhoto> galleryPhotos = (from pg in Database.PhotoGalleries
                                                    where pg.PhotoGalleryCategoryID == GalleryCategoryID
                                                    select new GallaryPhoto
                                                    {
                                                        ImagePath = pg.PhotoPath,
                                                        PhotoGalleryID = pg.PhotoGalleryID,
                                                        IsActive = pg.IsActive,
                                                        CreateDate = pg.CreateDate,
                                                        PhotoGalleryCategoryID = pg.PhotoGalleryCategoryID

                                                    }).ToList();

                galleryResult.GalleryPhotos = galleryPhotos;

                return galleryResult;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<DataAccess.PhotoGallery> GetAllActiveGalleryPhotos()
        {
            try
            {
               return Database.PhotoGalleries.Where(p => p.IsActive == true).ToList();

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

      
    }
}
