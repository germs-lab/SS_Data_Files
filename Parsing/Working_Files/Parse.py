import sys
File = sys.argv[2]
the_path = sys.argv[3]

for line in open(sys.argv[1]):
    dat = line.split('\t')[1]
    dat2 = dat.split('|')[-1]
    dat3 = dat2.split('_')[1]
    if dat3 == "megares":
        for AB_class in open('%s/Working_Files/Classes.list' %the_path):
            AB_C = AB_class.split('\n')[0]
            if dat.split('|')[-3] == AB_C:
                out = open('%s/%s.blast'  %(File, AB_C), 'a+')
                out.write(line)
                break
    elif dat3 == "card":
        code = dat2.split('_')[0][:3]
        out = ('%s/Uncategorized/%s.blast'  %(File, code))
        for AB_class in open('%s/Working_Files/Classes.list' %the_path):
            AB_C = AB_class.split('\n')[0]
            if code in open('%s/Working_Files/Keys/%s.list' %(the_path, AB_C)).read():
                out = ('%s/%s.blast'  %(File, AB_C))
                break
        open('%s' %out, 'a+').write(line)
    elif dat3 == "int":
        open('%s/Int.blast' %File, 'a+').write(line)