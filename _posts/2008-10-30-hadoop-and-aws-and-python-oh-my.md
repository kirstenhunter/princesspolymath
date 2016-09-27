---
id: 137
title: Hadoop and AWS and Python, Oh My!
date: 2008-10-30T12:13:35+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=137
permalink: /hadoop-and-aws-and-python-oh-my.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 1877196930
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
tags:
  - aws
  - hadoop
  - python
---
For an upcoming project at work, I needed to get a better idea of how the [AWS](http://aws.amazon.com/) services work together, and wanted to also see how the EC2 instances could be used for parallel processing.  Sadly, I do not love Java, and although I would use it if pressed, I wanted to see if I could find a pythony way to process some data using a hadoop setup. 

<div>
</div>

<div>
  So, based on <a href="http://www.michael-noll.com/wiki/Writing_An_Hadoop_MapReduce_Program_In_Python">this page</a>, I created a mapper and reducer in python. The mapper looks through a file and spits out lines for each match it finds.  The reducer takes the stdout from that process (using hadoop streaming) and does the thinking, then spits out the result. The examples on that page are a fine place to start for this piece.  And you can time the process on your system here to get an idea of the speedup using the hadoop setup.
</div>

<div>
</div>

<div>
  Next, I needed to get the files over to S3 so I can access them from my EC2 instance.  S3 instances are persistent, and transfers between S3 and EC2 are free, so I can run my processes an infinite number of times without incurring new costs for grabbing the files.  First, I created a bucket using the Python S3 tools, and then copied the files over using:
</div>

<div>
  <div>
  </div>
  
  <div>
    <span class="Apple-style-span" style="color: rgb(0, 0, 0); font-family: verdana; font-size: 12px; -webkit-border-horizontal-spacing: 3px; -webkit-border-vertical-spacing: 3px; "> 
    
    <pre style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-family: 'Courier New', Courier, mono; font-size: 12px; background-color: rgb(239, 247, 255); border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: dashed; border-right-style: dashed; border-bottom-style: dashed; border-left-style: dashed; border-top-color: rgb(51, 51, 51); border-right-color: rgb(51, 51, 51); border-bottom-color: rgb(51, 51, 51); border-left-color: rgb(51, 51, 51); overflow-x: auto; overflow-y: auto; width: 600px; padding-top: 15px; padding-right: 10px; padding-bottom: 15px; padding-left: 10px; "><span class="Apple-style-span" style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; white-space: normal; -webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: 0px; "><code>hadoop fs -put &lt;file> s3://ID:SECRET@BUCKET/name_of_dir</code></span></pre>
    
    <p>
      </span></div> </div> 
      
      <p>
        There are, of course, other ways to move things to S3 buckets.  Pick one you like. 
        
        <div>
        </div>
        
        <div>
          Now that all of my files are there for accessing, it&#8217;s time to set up the hadoop instance.  
        </div>
        
        <div>
        </div>
        
        <div>
          This part isn&#8217;t included in toto anywhere, so I&#8217;ll cover it here in detail.  This assumes you&#8217;ve done all of:
        </div>
        
        <div>
          <ul style="border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; font-size: 1em; font-weight: normal; margin-top: 0px; margin-right: 0px; margin-bottom: 0.75em; margin-left: 20px; background-repeat: repeat-y; list-style-type: disc; list-style-position: outside; list-style-image: initial; ">
            <li style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; font-size: 1em; font-weight: normal; ">
              Set up yourself with an AWS account with EC2 and S3 access (including setting up a properly permissioned id_rsa-gsg-keypair as described <a href="http://docs.amazonwebservices.com/AWSEC2/2007-08-29/GettingStartedGuide/running-an-instance.html" style="text-decoration: underline; ">here</a>)
            </li>
            <li style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; font-size: 1em; font-weight: normal; ">
              Created a bucket in S3 and populated it with files
            </li>
            <li style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; font-size: 1em; font-weight: normal; ">
              Created a mapper.py and reducer.py and tested them with your files
            </li>
            <li style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; font-size: 1em; font-weight: normal; ">
              Installed the hadoop tools on your local system and configured them as described <a href="http://wiki.apache.org/hadoop/AmazonEC2" style="text-decoration: underline; ">here</a>
            </li>
          </ul>
        </div>
        
        <div>
          Next, even though every piece of documentation says to do this:
        </div>
        
        <div>
          <span class="Apple-style-span" style="color: rgb(0, 0, 0); font-family: verdana; font-size: 12px; -webkit-border-horizontal-spacing: 3px; -webkit-border-vertical-spacing: 3px; "> 
          
          <pre style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-family: 'Courier New', Courier, mono; font-size: 12px; background-color: rgb(239, 247, 255); border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: dashed; border-right-style: dashed; border-bottom-style: dashed; border-left-style: dashed; border-top-color: rgb(51, 51, 51); border-right-color: rgb(51, 51, 51); border-bottom-color: rgb(51, 51, 51); border-left-color: rgb(51, 51, 51); overflow-x: auto; overflow-y: auto; width: 600px; padding-top: 15px; padding-right: 10px; padding-bottom: 15px; padding-left: 10px; ">bin/hadoop-ec2 run</pre>
          
          <p>
            </span></div> 
            
            <div>
            </div>
            
            <p>
              That&#8217;s a lie.  Try this instead: 
              
              <div>
                <span class="Apple-style-span" style="color: rgb(0, 0, 0); font-family: verdana; font-size: 12px; -webkit-border-horizontal-spacing: 3px; -webkit-border-vertical-spacing: 3px; "> 
                
                <pre style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-family: 'Courier New', Courier, mono; font-size: 12px; background-color: rgb(239, 247, 255); border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: dashed; border-right-style: dashed; border-bottom-style: dashed; border-left-style: dashed; border-top-color: rgb(51, 51, 51); border-right-color: rgb(51, 51, 51); border-bottom-color: rgb(51, 51, 51); border-left-color: rgb(51, 51, 51); overflow-x: auto; overflow-y: auto; width: 600px; padding-top: 15px; padding-right: 10px; padding-bottom: 15px; padding-left: 10px; ">bin/hadoop-ec2 launch-cluster &lt;group_name> &lt;number_of_slaves></pre>
                
                <p>
                  </span></div> 
                  
                  <div>
                  </div>
                  
                  <p>
                    This will create a master hadoop node, and your slaves. For number_of_slaves you want to pick something <= 19 so that your total doesn&#8217;t exceed 20 (unless you have special privileges). 
                    
                    <div>
                    </div>
                    
                    <p>
                      Now we have to move our snazzy mapper and reducer to the master: 
                      
                      <div>
                      </div>
                      
                      <div>
                        <span class="Apple-style-span" style="color: rgb(0, 0, 0); font-family: verdana; font-size: 12px; -webkit-border-horizontal-spacing: 3px; -webkit-border-vertical-spacing: 3px; "> 
                        
                        <pre style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-family: 'Courier New', Courier, mono; font-size: 12px; background-color: rgb(239, 247, 255); border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: dashed; border-right-style: dashed; border-bottom-style: dashed; border-left-style: dashed; border-top-color: rgb(51, 51, 51); border-right-color: rgb(51, 51, 51); border-bottom-color: rgb(51, 51, 51); border-left-color: rgb(51, 51, 51); overflow-x: auto; overflow-y: auto; width: 600px; padding-top: 15px; padding-right: 10px; padding-bottom: 15px; padding-left: 10px; ">bin/hadoop-ec2-env.sh
scp $SSH_OPTS /path/to/mapper.py root@$MASTER_HOST:/home
scp $SSH_OPTS /path/to/reducer.py root@$MASTER_HOST:/home</pre>
                        
                        <p>
                          </span></div> 
                          
                          <div>
                          </div>
                          
                          <p>
                            &#8216;run&#8217; apparently used to then log you into your master, but since we&#8217;re using launch-cluster, you&#8217;ll need to do it yourself: 
                            
                            <div>
                            </div>
                            
                            <div>
                              <span class="Apple-style-span" style="color: rgb(0, 0, 0); font-family: verdana; font-size: 12px; -webkit-border-horizontal-spacing: 3px; -webkit-border-vertical-spacing: 3px; "> 
                              
                              <pre style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-family: 'Courier New', Courier, mono; font-size: 12px; background-color: rgb(239, 247, 255); border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: dashed; border-right-style: dashed; border-bottom-style: dashed; border-left-style: dashed; border-top-color: rgb(51, 51, 51); border-right-color: rgb(51, 51, 51); border-bottom-color: rgb(51, 51, 51); border-left-color: rgb(51, 51, 51); overflow-x: auto; overflow-y: auto; width: 600px; padding-top: 15px; padding-right: 10px; padding-bottom: 15px; padding-left: 10px; ">ssh $SSH_OPTS root@&lt;your_new_master></pre>
                              
                              <p>
                                </span></div> 
                                
                                <div>
                                </div>
                                
                                <p>
                                  And there you are! On your new master. Awesome. Now let&#8217;s move the data to our cluster (ID and SECRET are your AWS credentials, BUCKET is the bucket you created):
                                </p>
                                
                                <div>
                                  <span class="Apple-style-span" style="color: rgb(0, 0, 0); font-family: verdana; font-size: 12px; -webkit-border-horizontal-spacing: 3px; -webkit-border-vertical-spacing: 3px; "> 
                                  
                                  <pre style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-family: 'Courier New', Courier, mono; font-size: 12px; background-color: rgb(239, 247, 255); border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: dashed; border-right-style: dashed; border-bottom-style: dashed; border-left-style: dashed; border-top-color: rgb(51, 51, 51); border-right-color: rgb(51, 51, 51); border-bottom-color: rgb(51, 51, 51); border-left-color: rgb(51, 51, 51); overflow-x: auto; overflow-y: auto; width: 600px; padding-top: 15px; padding-right: 10px; padding-bottom: 15px; padding-left: 10px; ">cd /usr/local/hadoop-<em>&lt;version></em>
bin/hadoop fs -mkdir files
bin/hadoop distcp s3://<em>&lt;ID></em>:<em>&lt;SECRET></em>@<em>&lt;BUCKET></em>/path/to/files files</pre>
                                  
                                  <p>
                                    </span></div> 
                                    
                                    <div>
                                    </div>
                                    
                                    <p>
                                      Ok, great. Almost there. Now we need to run the thing: 
                                      
                                      <div>
                                        <div>
                                          <span class="Apple-style-span" style="color: rgb(0, 0, 0); font-family: verdana; font-size: 12px; -webkit-border-horizontal-spacing: 3px; -webkit-border-vertical-spacing: 3px; "> 
                                          
                                          <pre style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-family: 'Courier New', Courier, mono; font-size: 12px; background-color: rgb(239, 247, 255); border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: dashed; border-right-style: dashed; border-bottom-style: dashed; border-left-style: dashed; border-top-color: rgb(51, 51, 51); border-right-color: rgb(51, 51, 51); border-bottom-color: rgb(51, 51, 51); border-left-color: rgb(51, 51, 51); overflow-x: auto; overflow-y: auto; width: 600px; padding-top: 15px; padding-right: 10px; padding-bottom: 15px; padding-left: 10px; ">hadoop@ubuntu:/usr/local/hadoop$ bin/hadoop jar contrib/streaming/hadoop-0.18.0-streaming.jar -mapper mapper.py -file /home/mapper.py -reducer reducer.py -file /home/reducer.py -input files/* -output map-reduce.output</pre>
                                          
                                          <p>
                                            </span></div> </div> 
                                            
                                            <p>
                                              While it&#8217;s running, you can check out the neat web report hadoop creates at http://<server_name>:50030.  Go ahead, check it out.  It&#8217;s totally cool.
                                            </p>