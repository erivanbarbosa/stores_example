import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/common/common_api.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/profile/profile_api.dart';
import 'package:redesprou_boilerplate_name/models/id_and_name.dart';
import 'package:redesprou_boilerplate_name/models/profile/create_profile.dart';
import 'package:redesprou_boilerplate_name/models/profile/profile.dart';
import 'package:redesprou_boilerplate_name/utils/date_utils.dart';
import 'package:redesprou_boilerplate_name/utils/image/imageUtils.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  @observable
  TextEditingController nameController = TextEditingController();
  @observable
  TextEditingController emailController = TextEditingController();
  @observable
  TextEditingController phoneController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();
  @observable
  TextEditingController confirmPasswordController = TextEditingController();
  @observable
  TextEditingController cpfController = TextEditingController();
  @observable
  TextEditingController instagramController = TextEditingController();
  @observable
  TextEditingController facebookController = TextEditingController();
  @observable
  TextEditingController neighborhoodController = TextEditingController();
  @observable
  TextEditingController zipController = TextEditingController();
  @observable
  TextEditingController addressOneController = TextEditingController();
  @observable
  TextEditingController addressTwoController = TextEditingController();
  @observable
  TextEditingController numberhoodController = TextEditingController();
  @observable
  TextEditingController occupationController = TextEditingController();
  @observable
  TextEditingController educationController = TextEditingController();
  @observable
  TextEditingController educationLocationController = TextEditingController();
  @observable
  TextEditingController educationDescriptionController = TextEditingController();
  @observable
  TextEditingController educationStartController = TextEditingController();
  @observable
  TextEditingController educationEndController = TextEditingController();
  @observable
  TextEditingController bioController = TextEditingController();
  @observable
  String? genre;
  @observable
  DateTime? birthDate;
  @observable
  int? state;
  @observable
  int? city;
/*   @observable
  DateTime? educationStart;
  @observable
  DateTime? educationEnd; */
  @observable
  String? educationStatus;

  @observable
  Profile? profile;

  @observable
  bool loading = false;

  @observable
  bool imageLoading = false;

  @observable
  List<IdAndName>? cities;

  @observable
  List<IdAndName>? states;

  @action
  Future<void> saveProfile() async {
    ProfileApi profileApi = ProfileApi();
    this.loading = true;
    Profile profile = Profile(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        cpf: cpfController.text,
        instagram_url: instagramController.text,
        facebook_url: facebookController.text,
        zipcode: zipController.text,
        genre: genre,
        address_1: addressOneController.text,
        address_2: addressTwoController.text,
        city_id: city != null ? city : null,
        occupation: occupationController.text,
        education: educationController.text,
        education_location: educationLocationController.text,
        education_description: educationDescriptionController.text,
        education_start: educationStartController.text,
        education_end: educationEndController.text,
        education_status: educationStatus,
        birthdate: birthDate != null ? fromDateTimeToYYYYMMDD(birthDate!) : null,
        bio: bioController.text);

    await profileApi.saveProfile(profile).whenComplete(() => loading = false);
  }

  @action
  getProfile() async {
    loading = true;
    ProfileApi profileApi = ProfileApi();
    Profile profileFound = await profileApi.findProfile().whenComplete(() => loading = false);
    profile = profileFound;
    _loadProfileForm(profile);
    if (profile!.state_id != null) {
      this.state = profile!.state_id;
      findCities();
    }
  }

  void _loadProfileForm(Profile? profile) {
    if (profile != null) {
      nameController.text = profile.name ?? "";
      genre = profile.genre ?? "";
      cpfController.text = profile.cpf ?? "";
      instagramController.text = profile.instagram_url ?? "";
      facebookController.text = profile.facebook_url ?? "";
      zipController.text = profile.zipcode ?? "";
      addressOneController.text = profile.address_1 ?? "";
      addressTwoController.text = profile.address_2 ?? "";
      birthDate = fromStringToDate(profile.birthdate);
      occupationController.text = profile.occupation ?? "";
      educationController.text = profile.education ?? "";
      educationLocationController.text = profile.education_location ?? "";
      educationDescriptionController.text = profile.education_description ?? "";
      educationStatus = profile.education_status != null && profile.education_status!.isNotEmpty ? profile.education_status : null;
      educationStartController.text = profile.education_start ?? "";
      educationEndController.text = profile.education_end ?? "";
      //educationStart = fromStringToDate(profile.education_start);
      //educationEnd = fromStringToDate(profile.education_end);
      city = profile.city_id != null ? profile.city_id! : null;
      emailController.text = profile.email ?? "";
      phoneController.text = profile.phone ?? "";
      bioController.text = profile.bio ?? "";
    }
  }

  @action
  findCities() async {
    CommonApi commonApi = CommonApi();
    List<IdAndName> cities = await commonApi.findCities(stateId: state);
    this.cities = cities;
  }

  @action
  findStates() async {
    CommonApi commonApi = CommonApi();
    List<IdAndName> states = await commonApi.findStates();
    this.states = states;
  }

  @action
  addAvatar() async {
    ProfileApi profileApi = ProfileApi();
    String image = await pickImage();
    imageLoading = true;
    await profileApi.addAvatar(image);
    Profile profileFound = await profileApi.findProfile().whenComplete(() => imageLoading = false);
    this.profile!.profile_photo_path = profileFound.profile_photo_path!;
  }

  @action
  addCover() async {
    ProfileApi profileApi = ProfileApi();
    String image = await pickImage();
    imageLoading = true;
    await profileApi.addCover(image);
    Profile profileFound = await profileApi.findProfile().whenComplete(() => imageLoading = false);
    this.profile!.featured_photo_path = profileFound.featured_photo_path!;
  }

  @action
  createProfile() async {
    loading = true;
    ProfileApi profileApi = ProfileApi();
    CreateProfile profile = CreateProfile(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      password_confirmation: confirmPasswordController.text,
    );

    await profileApi.createProfile(profile).whenComplete(() => loading = false);
  }

  @action
  Future<void> reset() async {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    cpfController = TextEditingController();
    instagramController = TextEditingController();
    facebookController = TextEditingController();
    neighborhoodController = TextEditingController();
    zipController = TextEditingController();
    addressOneController = TextEditingController();
    addressTwoController = TextEditingController();
    numberhoodController = TextEditingController();
    occupationController = TextEditingController();
    educationController = TextEditingController();
    educationLocationController = TextEditingController();
    educationDescriptionController = TextEditingController();
    educationStartController = TextEditingController();
    educationEndController = TextEditingController();
    bioController = TextEditingController();
  }
}
