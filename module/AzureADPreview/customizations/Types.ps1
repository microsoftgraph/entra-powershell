# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

@{
        "Microsoft.Open.MSGraph.Model.DirectorySettingTemplate" = @"
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
}
