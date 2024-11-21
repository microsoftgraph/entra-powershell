# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

@{
        "Microsoft.Open.MSGraph.Model.DirectorySettingTemplate" = @"
        public System.String Id;
        public System.String DisplayName;
        public System.String Description;
        public System.Collections.Generic.List<Microsoft.Open.MSGraph.Model.SettingTemplateValue> Values;

        public DirectorySetting CreateDirectorySetting()
        {
            DirectorySetting directorySetting = new DirectorySetting();

            directorySetting.TemplateId = this.Id;

            directorySetting.Values = new System.Collections.Generic.List<SettingValue>();
            foreach (var definition in this.Values)
            {
                SettingValue item = new SettingValue();
                item.Name = definition.Name;

                string value = definition.DefaultValue;
                if (string.IsNullOrEmpty(value))
                {
                    item.Value = value;
                }
                else if (value.Length == 1)
                {
                    item.Value = value.ToUpper();
                }
                else
                {
                    item.Value = char.ToUpper(value[0]) + value.Substring(1);
                }

                directorySetting.Values.Add(item);
            }

            return directorySetting;
        }
"@
        "Microsoft.Open.MSGraph.Model.DirectorySetting" = @"
        public System.String Id;
        public System.String DisplayName;
        public System.String TemplateId;
        public System.Collections.Generic.List<Microsoft.Open.MSGraph.Model.SettingValue> Values;
        
        public string this[string name]
        {
            get
            {
                SettingValue setting = this.Values.FirstOrDefault(namevaluepair => namevaluepair.Name.Equals(name));
                return (setting != null) ? setting.Value : string.Empty;
            }
            set
            {
                SettingValue setting = this.Values.FirstOrDefault(namevaluepair => namevaluepair.Name.Equals(name));
                if (setting != null)
                {
                    // Capitalize the forst character of the value.
                    if (string.IsNullOrEmpty(value))
                    {
                        setting.Value = value;
                    }
                    else if (value.Length == 1)
                    {
                        setting.Value = value.ToUpper();
                    }
                    else
                    {
                        setting.Value = char.ToUpper(value[0]) + value.Substring(1);
                    }
                }
            }
        }
"@
"Microsoft.Open.AzureAD.Model.AppRole" = @"
        public System.Collections.Generic.List<System.String> AllowedMemberTypes;
        public System.String Description;
        public System.String DisplayName;
        public System.String Id;
        public System.Nullable<System.Boolean> IsEnabled;
        public System.String Origin;
        public System.String Value;
"@
}

