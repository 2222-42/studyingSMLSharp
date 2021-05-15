fun 'a#reify castLike data (sample: 'a) =
    Dynamic.view (_dynamic data as 'a Dynamic.dyn);
